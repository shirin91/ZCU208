

/***************************** Include Files *********************************/
#include <stdio.h>
#include <stdlib.h>
#include "xil_io.h"
#include "xil_types.h"
#include "xparameters.h"
#include "xrfdc.h"
#include "xrfdc_mts.h"
#include "main.h"
#include "rfdc_interpolation_decimation.h"

/************************** Constant Definitions *****************************/

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

/************************** Variable Definitions *****************************/

/************************** Function Definitions ******************************/

/*****************************************************************************/
/**
*
* ADC Decimation Report
*
* @param
*
* @return	None
*
* @note		TBD
*
******************************************************************************/
void adcGetDecimation(u32 *cmdVals)
{
	int Status;
	XRFdc *RFdcInstPtr = &RFdcInst;
	XRFdc_IPStatus ipStatus;
	u32 DecimationFactortest;
	int Tile_Id;
	int Block_Id;
	xil_printf("\r\n###############################################\r\n");

	// Calling this function gets the status of the IP
	XRFdc_GetIPStatus(RFdcInstPtr, &ipStatus);

	xil_printf("ADC Decimation Setting\r\n");
	for (Tile_Id = 0; Tile_Id <= 3; Tile_Id++)
	{
		if (ipStatus.ADCTileStatus[Tile_Id].IsEnabled == 1)
		{
			for (Block_Id = 0; Block_Id <= 3; Block_Id++)
			{
				if (XRFdc_IsADCBlockEnabled(RFdcInstPtr, Tile_Id, Block_Id))
				{

					Status = XRFdc_GetDecimationFactor(RFdcInstPtr, Tile_Id, Block_Id, &DecimationFactortest);
					if (Status != XST_SUCCESS)
					{
						xil_printf("XRFdc_GetDecimationFactor() failed\r\n");
						return;
					}
				}
				if (ipStatus.ADCTileStatus[Tile_Id].IsEnabled == 1)
				{
					if (XRFdc_IsADCBlockEnabled(RFdcInstPtr, Tile_Id, Block_Id))
					{
						xil_printf("    ADC Tile%d ch%d Decimation Factor:  %d\r\n", Tile_Id, Block_Id, DecimationFactortest);
					}
				}
			}
		}
	}

	xil_printf("###############################################\r\n\n");

	return;
}

/*****************************************************************************/
/**
*
* DAC Interpolation Report
*
* @param
*
* @return	None
*
* @note		TBD
*
******************************************************************************/
void dacGetInterpolation(u32 *cmdVals)
{
	int Status;
	XRFdc *RFdcInstPtr = &RFdcInst;
	XRFdc_IPStatus ipStatus;
	u32 InterpolationFactortest;
	int Tile_Id;
	int Block_Id;
	xil_printf("\r\n###############################################\r\n");

	// Calling this function gets the status of the IP
	XRFdc_GetIPStatus(RFdcInstPtr, &ipStatus);

	xil_printf("DAC Interpolation Setting\r\n");
	for (Tile_Id = 0; Tile_Id <= 3; Tile_Id++)
	{

		if (ipStatus.DACTileStatus[Tile_Id].IsEnabled == 1)
		{
			for (Block_Id = 0; Block_Id <= 3; Block_Id++)
			{
				if (XRFdc_IsDACBlockEnabled(RFdcInstPtr, Tile_Id, Block_Id))
				{
					Status = XRFdc_GetInterpolationFactor(RFdcInstPtr, Tile_Id, Block_Id, &InterpolationFactortest);
					if (Status != XST_SUCCESS)
					{
						xil_printf("XRFdc_GetInterpolationFactor() failed\r\n");
						return;
					}
				}
				if (ipStatus.DACTileStatus[Tile_Id].IsEnabled == 1)
				{
					if (XRFdc_IsDACBlockEnabled(RFdcInstPtr, Tile_Id, Block_Id))
					{
						xil_printf("    DAC Tile%d ch%d Interpolation Factor:  %d\r\n", Tile_Id, Block_Id, InterpolationFactortest);
					}
				}
			}
		}
	}

	xil_printf("###############################################\r\n\n");

	return;
}
