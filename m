Return-Path: <linux-can+bounces-218-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C11C84CABD
	for <lists+linux-can@lfdr.de>; Wed,  7 Feb 2024 13:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5785B1F21E14
	for <lists+linux-can@lfdr.de>; Wed,  7 Feb 2024 12:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4BB6994C;
	Wed,  7 Feb 2024 12:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b="eXmB/ztB"
X-Original-To: linux-can@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2130.outbound.protection.outlook.com [40.107.7.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD3A67C51
	for <linux-can@vger.kernel.org>; Wed,  7 Feb 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707309139; cv=fail; b=ZBjJOMpAVd/sCTJFySiX1PoXqJtNf9eaUIVU4VPpLtmZYMPX/BSy0DO3Ro3Hab+g29ezr4JnOANiRtYKzjVf8pgHAheu6IwQpF1Z2dBa8xYLAPq/bfmU3cQzL4zZ3zc1t0QdkL4Vx490aDvonx/lUrej4QFf5F40OYDfpR2iSDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707309139; c=relaxed/simple;
	bh=R4z1yfTbSOTGfUNCNajR3L2J6SgvW8xepy0tT/oK2u0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VvwJGtuM5deFokhjnF29WLzYxAVLilR0f/pWomHEl8MtWITWCS+hR9ZhsCjNi5DiOFV7awMxcgHd1nEIZLNAhkEZtKCsC6MGEn05cC7YFgDqBk5RxHo/RwL4zKBL7/5VyODLJW4Ae35vgK6G8P+W0gQgIceaTN5GzEoILo7VdFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com; spf=pass smtp.mailfrom=kvaser.com; dkim=pass (1024-bit key) header.d=kvaser.com header.i=@kvaser.com header.b=eXmB/ztB; arc=fail smtp.client-ip=40.107.7.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kvaser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kvaser.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlSeCRdLGyex5pCUv3KJxoVboD36OYB2H3UMJMTlCJdjnhXD9RFtEup7YZvwQnr2PPpt4M+3JOrqlXh2I+CVFR2WVrd0er1fqKxx2owAv41JwCsz8H8dK2/I5hmWi4h5iG0NX3cSABr00Werr8XS56wdb4UbqyXz3ukyzn+ON5RE8GOeSDNsIbnKStkn96Wk1qvuC4KgbBXlWdW/P+ruKnuUvHiUlaSReKbAstFMS9RvWMta2A+nK3QHzZ0990BD8xy64aF47n4GNKtImVTviZow4iAsu/wwnneRQPTpFSj+uujQmmRGSFAXVqDVzxnd5LW99gntFT0n71tNhwaM5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ZKh39sAIq+FsK4zZaErzf5itnc1LUPBrF8hv17uKQc=;
 b=F5832axifYCV3eFOkVLkcth5jQzkZBJQ3QRix2zd5F77cjlJ5pbME1V37EP8WLelbvQ/qVptjTzTa/za85a0N5Cu25i+xxhvi4GsMMEA42Erc+Ob7/EocnYv4rLfgHRZ3UZtNyrNwWGzloc37gqCkXFjOk/6x9N4aJxVybuK8QpKTQuOejONu8z268Zf9FUvz4sNwIpTA+89q7PjMV6OImm3A14UrJ5m44oXIgwLdB+qtiBei1UtKHd8c7G/qMiZlNWkhm1whGWL9ATx6J3oWODkixpp8Xc79FYAgnJtlEsklVsmSaRJJWci/cNkyaANYoo+qaqrmtp+ijJ/LEzR/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kvaser.com; dmarc=pass action=none header.from=kvaser.com;
 dkim=pass header.d=kvaser.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kvaser.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ZKh39sAIq+FsK4zZaErzf5itnc1LUPBrF8hv17uKQc=;
 b=eXmB/ztBQWQJQPx/CKe+mzKtDNtda5e5mNqcRY/e20S4f0SEfHAjInKLP0c9VxP2gAXqUHO0RXqvNwzxobm9BLhjmpPPwfPesLmBQokUUXVDxuL5ITjz0q9dAurG4brLru5X5+ZjD3kBNwk1H2ZcYpCEcZfwRkoKV7vyKC+pyB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kvaser.com;
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40d::20)
 by AM9P193MB1587.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:309::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 12:32:11 +0000
Received: from AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::8236:dccd:3358:876]) by AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 ([fe80::8236:dccd:3358:876%7]) with mapi id 15.20.7249.037; Wed, 7 Feb 2024
 12:32:11 +0000
Message-ID: <375e7f6d-9ac0-8b59-9394-72adb07d03f8@kvaser.com>
Date: Wed, 7 Feb 2024 13:32:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] can: kvaser_pciefd: Add support for Kvaser M.2 PCIe 4xCAN
To: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jimmy Assarsson <jimmyassarsson@gmail.com>
References: <20231113134717.515037-1-extja@kvaser.com>
Content-Language: en-US
From: Jimmy Assarsson <extja@kvaser.com>
In-Reply-To: <20231113134717.515037-1-extja@kvaser.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0104.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::21) To AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40d::20)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2014:EE_|AM9P193MB1587:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f8b5776-9771-4e46-2756-08dc27d8ce75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d7S7NLhfZ+VlDfqwXAMJvnt9hOpLObeYixsBCgWynJajr4gCHgoncBCEci3wr7jK4477hB6b6n18y35tei0I9c6fI9gpiipeD2l8PVatNa0ssFtrpu2ScWOcDBjvoMV32iQ4YPNq0V94vAgU3CFdCCSvBJqFUwBkOFDd0zEsnARARXw50+olyM6KerCL1zBd7pxcz0D8I5vz650EyQy1K1I5QgZh/8GYsTbvDheKkldex9SWc7qEOBkzrA0HsIpIVDjTHgxkhxdU4yw0HNtZGKfSOi5mQIsAGSG9gDxyrl7Tz/JmS1G3a5KFik/IdpaMGGerNMpf8ynVu6MPPsY4DKRasU2JtHxQgLKrh7zG7kRZCRpS+SnBeIUYmYdqQN8A/MPODlWyPh/vXmS+2sHUbobnwzVSqK7mMidUC1/iIowFNtO6wDZ5kjc1lUQRyCCz0y7czivVASZDq1rXw1tOmD/nLHANYlIa3BfDzzdhR17wJcgaGDlwVB2iu0lkkAlqNgMEkot6OAyh6ZWSIqJEP5hOr6e7beg0LaCq8dK1MBmmOs12QMOorTZNl3mY69jUJ+D6cMYdPCByuiOW2c36S472a/yeSL7K/1kZU/m3BrLvypSZVb5CgpACOLRaSGfK44Bigho9jwGd8eLkn+9KHA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB2014.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39840400004)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(31686004)(41300700001)(31696002)(38100700002)(26005)(2616005)(86362001)(6506007)(6512007)(66556008)(6916009)(53546011)(66476007)(478600001)(6486002)(66946007)(36756003)(8936002)(4326008)(8676002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rmo0WkR4b1VZU0N0bmdRY0hCcWFKenNMWmxLRDFWck1GTDFUVHV4WDhLemxN?=
 =?utf-8?B?azFrazMxRXVORlZTV1Vacm9xTWs4SDUyZ1FZd2piOEVDbGNVQlhmZDRDY0dT?=
 =?utf-8?B?VGszMWpkN2JMYVZYWlJLTWpxQU1za1hyaTZSK1ZrQXd5bkJzZFhzdkdwVDRo?=
 =?utf-8?B?VFh2b3Q4cVRTUE5kVjhENUFKVklTVW5ZaGJKUnB4TUxMVFYybzQweFUvK0RF?=
 =?utf-8?B?SEc0aVRhS0RValBpaENOVTlSQ2JoQmZtbWViQVIyQ01mcEpIekQvNEFBY1FD?=
 =?utf-8?B?MFdHN090dmlRTWQ4d0NWYzQxOUZnU1J6b0tJUjNJYzBSMldWcXpJaEtXMlU0?=
 =?utf-8?B?VUxBSUx0UXdnVzM2QWhDRElZS0U4MzA1K2lycXVicjBOZkVXeVYvdkpDeitL?=
 =?utf-8?B?WXA5aXU0dVkva3ozV0RMSDl1aEJlS2J2M0d5akdESld5NmxTMmdwSDJlRUQr?=
 =?utf-8?B?d01rSG5GQXRieE9lS04wb2tSQ08yQXVlY2g1SkJHemZOOXhQeElaSDZIai9U?=
 =?utf-8?B?ZVdYNlZwUjJHaDVHNDRPMC9KNkQxTlR0YnJoNmZJdStxZTZPMlZtWm9lVGN5?=
 =?utf-8?B?dXd4TjQ4azlicWpLTW5IbzgwUklKRkoyNHpHbTNvK25mQkFHMTZldXc4Nncr?=
 =?utf-8?B?cDVIYmJVaXU0NEVVQitaN28yMUlzRFhRb2pVWHpSVWpmbVpKdDdvODFrSHJJ?=
 =?utf-8?B?NHZ4Q1h5VXVpQTk1em9vMGlsYitmdmpWNEtMcDdUUzdpNStHenNPQzhBRi9M?=
 =?utf-8?B?Z0orcXRQTkNxaTJJQjZ2V3pvMUluaGFmU1NkNDNnRktHUThhWDljazZJdW1u?=
 =?utf-8?B?NzUrWTdwbHJOdXUxdENEL0pyWktka24vQS82Q1hvK2pZVG1xVi8rSDJiQUpY?=
 =?utf-8?B?cUQ4SnRLVGVSdXBuTzhzc1c3aXJsYnJ2eWt3VkorOHN1RVFjaVo0VS9UR2hK?=
 =?utf-8?B?dWw1RzdCNFVrZzgrNE9KU2dmS2FRYURsWjdpOXgrTmIvd2NVQjN3T1Y0b2Zo?=
 =?utf-8?B?WUtwWklpUjNZQjBJdHV5aVpmYklRTzlHZVl6ekZiWnAzczNSU2tYT2kzNndp?=
 =?utf-8?B?WFFTa2N0OVE1SXA3Y0NlTVlDTlprRTZyd3V6WWZFVUU4ZXR0OFBUcUF6WDRk?=
 =?utf-8?B?ei93enBvbXZBdWFXQ3NnVVI0YnZhNUM5TTUwdmY5UmFpMFJIcm9pMC9rbzFs?=
 =?utf-8?B?VzlrblhyQUZjdE9aQXV1VXpDUS8vcVNaNnZ3OTI0S2M5L05NbUdUaU0xMmQr?=
 =?utf-8?B?TVdMUHZmOUZ4Um9rYkhCblcwYk8vWlViZjZEZ3N3MzdReG1YV2k3SVI2VU5z?=
 =?utf-8?B?Q2ZwZUlBbW4zSHZxZDBHWFN2akdvbnRLY1c5WW1KOTBZb3diS3p5VFlWRkda?=
 =?utf-8?B?TCt3ZjBDMDlDazZ0L0ZtVTRCSVlVZkRjb05XZHBBR216WEtDV21KUmxzbjVo?=
 =?utf-8?B?OGJoTlIxRjdDTjFEN3NlUWNmTjlZSnBDZk1xS1RrMi9HKzlqYVdtdFBwaGxJ?=
 =?utf-8?B?Y1I3c3UraXhRMVJiMjdjRnlqbk5reldXUWZ0dGVsVXpGemdwbzN6UEN0bG9m?=
 =?utf-8?B?V0E5VklPLzVoN0NHZW95VzdQeEM5dkZjQVk1QkFNaEZYZUkxNFlJS3M5VUU1?=
 =?utf-8?B?SU5sN0hvazdwNE5saFRLS2RDUlJkOVZkRmlsRmV1bVZreS9yRGlvdm9LU1U5?=
 =?utf-8?B?R2VOU3hQbEoyUlB5OW1jZThRUVZLYUhKY3RyVU01eU84K2xGQkZ2Ty9xTmJ2?=
 =?utf-8?B?S1BkQ09SZ3hUbnNlayttTUVaN09adlBtWnRIWG5hajRnQ0YzNWN4aSsvYU1j?=
 =?utf-8?B?cStqVFlRTjZseC9qa2txd2x1R3ZYSnIxeCsveW1pLzRaVFFmV1pjL1pWUWll?=
 =?utf-8?B?OU5lWUpEa0hFakhRNWcyUXorT3NIc0N2dlAwL3ljTUZERmxsODBGSytVZEVu?=
 =?utf-8?B?RTR5MDJHV0FiaFBZdU13eFRiWFFmTWZFMkNKQ2RJV2pBMm42eFpMVmRaRTdZ?=
 =?utf-8?B?cHFNS29PdG1ETVB4WFI3SVUrbkpyTVJCNlFibFBTbklJT1ZhZE5LWDBmZXgx?=
 =?utf-8?B?M3NURnBxYm9zWE45azNML1ovY0ZPUVI5ODBRYm8vV1F3c1ZaWWVwRE1PZll0?=
 =?utf-8?Q?3xR+ZNbs87TktAacJDk016IQu?=
X-OriginatorOrg: kvaser.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f8b5776-9771-4e46-2756-08dc27d8ce75
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2014.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 12:32:11.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 73c42141-e364-4232-a80b-d96bd34367f3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fBNbADjB6W7mPMosy03nPqvZyg5mdVq062NYGAg1r3QWUtO+UCaeMDkFHbSj9tzn13R57eDoyRJ7yApCBABSsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1587

Gentle ping.

Best regards,
jimmy

On 11/13/23 14:47, Jimmy Assarsson wrote:
> Add support for new Kvaser pciefd device, M.2 PCIe 4xCAN, based on
> Xilinx FPGA.
> 
> Signed-off-by: Jimmy Assarsson <extja@kvaser.com>
> ---
>   drivers/net/can/Kconfig         |  1 +
>   drivers/net/can/kvaser_pciefd.c | 55 +++++++++++++++++++++++++++++++++
>   2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> index eb410714afc2..e18263bf3e0a 100644
> --- a/drivers/net/can/Kconfig
> +++ b/drivers/net/can/Kconfig
> @@ -168,6 +168,7 @@ config CAN_KVASER_PCIEFD
>   	    Kvaser Mini PCI Express 2xHS v2
>   	    Kvaser Mini PCI Express 1xCAN v3
>   	    Kvaser Mini PCI Express 2xCAN v3
> +	    Kvaser M.2 PCIe 4xCAN
>   
>   config CAN_SLCAN
>   	tristate "Serial / USB serial CAN Adaptors (slcan)"
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> index a57005faa04f..416f10480b40 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -47,12 +47,18 @@ MODULE_DESCRIPTION("CAN driver for Kvaser CAN/PCIe devices");
>   #define KVASER_PCIEFD_MINIPCIE_2CAN_V3_DEVICE_ID 0x0015
>   #define KVASER_PCIEFD_MINIPCIE_1CAN_V3_DEVICE_ID 0x0016
>   
> +/* Xilinx based devices */
> +#define KVASER_PCIEFD_M2_4CAN_DEVICE_ID 0x0017
> +
>   /* Altera SerDes Enable 64-bit DMA address translation */
>   #define KVASER_PCIEFD_ALTERA_DMA_64BIT BIT(0)
>   
>   /* SmartFusion2 SerDes LSB address translation mask */
>   #define KVASER_PCIEFD_SF2_DMA_LSB_MASK GENMASK(31, 12)
>   
> +/* Xilinx SerDes LSB address translation mask */
> +#define KVASER_PCIEFD_XILINX_DMA_LSB_MASK GENMASK(31, 12)
> +
>   /* Kvaser KCAN CAN controller registers */
>   #define KVASER_PCIEFD_KCAN_FIFO_REG 0x100
>   #define KVASER_PCIEFD_KCAN_FIFO_LAST_REG 0x180
> @@ -281,6 +287,8 @@ static void kvaser_pciefd_write_dma_map_altera(struct kvaser_pciefd *pcie,
>   					       dma_addr_t addr, int index);
>   static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
>   					    dma_addr_t addr, int index);
> +static void kvaser_pciefd_write_dma_map_xilinx(struct kvaser_pciefd *pcie,
> +					       dma_addr_t addr, int index);
>   
>   struct kvaser_pciefd_address_offset {
>   	u32 serdes;
> @@ -335,6 +343,18 @@ static const struct kvaser_pciefd_address_offset kvaser_pciefd_sf2_address_offse
>   	.kcan_ch1 = 0x142000,
>   };
>   
> +static const struct kvaser_pciefd_address_offset kvaser_pciefd_xilinx_address_offset = {
> +	.serdes = 0x00208,
> +	.pci_ien = 0x102004,
> +	.pci_irq = 0x102008,
> +	.sysid = 0x100000,
> +	.loopback = 0x103000,
> +	.kcan_srb_fifo = 0x120000,
> +	.kcan_srb = 0x121000,
> +	.kcan_ch0 = 0x140000,
> +	.kcan_ch1 = 0x142000,
> +};
> +
>   static const struct kvaser_pciefd_irq_mask kvaser_pciefd_altera_irq_mask = {
>   	.kcan_rx0 = BIT(4),
>   	.kcan_tx = { BIT(0), BIT(1), BIT(2), BIT(3) },
> @@ -347,6 +367,12 @@ static const struct kvaser_pciefd_irq_mask kvaser_pciefd_sf2_irq_mask = {
>   	.all = GENMASK(19, 16) | BIT(4),
>   };
>   
> +static const struct kvaser_pciefd_irq_mask kvaser_pciefd_xilinx_irq_mask = {
> +	.kcan_rx0 = BIT(4),
> +	.kcan_tx = { BIT(16), BIT(17), BIT(18), BIT(19) },
> +	.all = GENMASK(19, 16) | BIT(4),
> +};
> +
>   static const struct kvaser_pciefd_dev_ops kvaser_pciefd_altera_dev_ops = {
>   	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_altera,
>   };
> @@ -355,6 +381,10 @@ static const struct kvaser_pciefd_dev_ops kvaser_pciefd_sf2_dev_ops = {
>   	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_sf2,
>   };
>   
> +static const struct kvaser_pciefd_dev_ops kvaser_pciefd_xilinx_dev_ops = {
> +	.kvaser_pciefd_write_dma_map = kvaser_pciefd_write_dma_map_xilinx,
> +};
> +
>   static const struct kvaser_pciefd_driver_data kvaser_pciefd_altera_driver_data = {
>   	.address_offset = &kvaser_pciefd_altera_address_offset,
>   	.irq_mask = &kvaser_pciefd_altera_irq_mask,
> @@ -367,6 +397,12 @@ static const struct kvaser_pciefd_driver_data kvaser_pciefd_sf2_driver_data = {
>   	.ops = &kvaser_pciefd_sf2_dev_ops,
>   };
>   
> +static const struct kvaser_pciefd_driver_data kvaser_pciefd_xilinx_driver_data = {
> +	.address_offset = &kvaser_pciefd_xilinx_address_offset,
> +	.irq_mask = &kvaser_pciefd_xilinx_irq_mask,
> +	.ops = &kvaser_pciefd_xilinx_dev_ops,
> +};
> +
>   struct kvaser_pciefd_can {
>   	struct can_priv can;
>   	struct kvaser_pciefd *kv_pcie;
> @@ -456,6 +492,10 @@ static struct pci_device_id kvaser_pciefd_id_table[] = {
>   		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_MINIPCIE_1CAN_V3_DEVICE_ID),
>   		.driver_data = (kernel_ulong_t)&kvaser_pciefd_sf2_driver_data,
>   	},
> +	{
> +		PCI_DEVICE(KVASER_PCIEFD_VENDOR, KVASER_PCIEFD_M2_4CAN_DEVICE_ID),
> +		.driver_data = (kernel_ulong_t)&kvaser_pciefd_xilinx_driver_data,
> +	},
>   	{
>   		0,
>   	},
> @@ -1035,6 +1075,21 @@ static void kvaser_pciefd_write_dma_map_sf2(struct kvaser_pciefd *pcie,
>   	iowrite32(msb, serdes_base + 0x4);
>   }
>   
> +static void kvaser_pciefd_write_dma_map_xilinx(struct kvaser_pciefd *pcie,
> +					       dma_addr_t addr, int index)
> +{
> +	void __iomem *serdes_base;
> +	u32 lsb = addr & KVASER_PCIEFD_XILINX_DMA_LSB_MASK;
> +	u32 msb = 0x0;
> +
> +#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
> +	msb = addr >> 32;
> +#endif
> +	serdes_base = KVASER_PCIEFD_SERDES_ADDR(pcie) + 0x8 * index;
> +	iowrite32(msb, serdes_base);
> +	iowrite32(lsb, serdes_base + 0x4);
> +}
> +
>   static int kvaser_pciefd_setup_dma(struct kvaser_pciefd *pcie)
>   {
>   	int i;

