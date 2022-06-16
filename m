Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF74254DFEA
	for <lists+linux-can@lfdr.de>; Thu, 16 Jun 2022 13:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376758AbiFPLWA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 16 Jun 2022 07:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376720AbiFPLV7 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 16 Jun 2022 07:21:59 -0400
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20136.outbound.protection.outlook.com [40.107.2.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF0E5E767
        for <linux-can@vger.kernel.org>; Thu, 16 Jun 2022 04:21:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDpVje7O3/flKsVMKcEki84R6l5z8HsPgnxhlSX5Voq7Q/OuNNa5RdfJgz5H5rWcEEBvAZsBzzkNfsintUDsagNgvwpA9ld8fso3GKopqQneYpfak+ASA5gJ50K2T130LmlOan61s1LQRpOBlHWm+vx2Ygiu/PfDT4vaFWYtEsFtDuMzVhTLyuJqaNKMNxs9BMKueHGGlSFCr0OXcaNGvHJV0ypzdIPERk0X11V9G2fEv+mfJIvd7kdvBu2TNJUVpjYjVlT+Q3U1Xu1UT2a7B39I+ep4Jb3xZ6JGiPk73GnaaPPGM985+IRU/z6Ng+KwPie9ONrF7FXD80FoQj5BjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgZv+frbk9HOd6kBHSfJs3vz8Vsxw8EDgUVL6Yi+nM0=;
 b=ID0yYsKTQJsev92IVQnzlvpmTqg/tir4TMKWLO27uoBo91aPqNPVO17R5kbLsy8whbzT2Wx3y1UYqnwfxARsEZdd/sf844AILHm8laj4rKXt9uwVXTOsY9GDkCuT9iMeGsescl2+dPQ2rpGRGldmVSwBXCqIh2UiLBlbK1ENVjssgyRUbozxkhVsDgSxAhi5TOV6BpU04LcVdbp0ai+/3hJYV3z7RW9AaLsi4GILX15S7Vy1hLCbcBl3orbKsSom8/cfuOM5OWR2O7lDkRpxHAexXIVzldFM3ZPU9X/+Txz1g7GMXhDY7JP6KeQhkFUz6rCoKA5VkWJtnb/vgAJxuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgZv+frbk9HOd6kBHSfJs3vz8Vsxw8EDgUVL6Yi+nM0=;
 b=Vhhcnfz1/6TrYO1l9AmnDLafZbvW2wqpBvTx9IOxGvjJ3iThLXnaXgEvnDCaz3HUob07QzcKWzecPnc7YHYXfN0oB9C6jgGlzZpJjd3m6P9dodIdtG3VB28vY2gUdRAbRgYKtia4yCKT1AoqQ00pRvouPiB2U/s0381GXaF41aM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Thu, 16 Jun
 2022 11:21:55 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8%5]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 11:21:55 +0000
Message-ID: <d614f497-b8f2-68cd-745b-1e3be2b991d5@prevas.dk>
Date:   Thu, 16 Jun 2022 13:21:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: ram initialization on mcp2518fd
Content-Language: en-US
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     info@pengutronix.de,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <e3f73c56-1b46-4ee9-357e-40400c746e09@prevas.dk>
 <87wndgyl2l.fsf@hardanger.blackshift.org>
 <441514ec-7b43-e11c-09b5-bdaf7fca0077@prevas.dk>
In-Reply-To: <441514ec-7b43-e11c-09b5-bdaf7fca0077@prevas.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0051.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::35) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7550260-5dde-4ef0-69c0-08da4f8a6b4a
X-MS-TrafficTypeDiagnostic: DB7PR10MB2490:EE_
X-Microsoft-Antispam-PRVS: <DB7PR10MB2490923BAB646F5ED18FC86993AC9@DB7PR10MB2490.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mltQFVU/vVEjBedMC82hBGoLC1QqrXBokD5dD/RqdcKZp1QUGs0kDYhXbUKKXLCJmfD1NDLdLra1sc5+kc5iAGoxrW3f4/r7ot/jRVd5iwVALFs5t6ibugDtPVK4jEWrkmAyIXoGdD+q60aXc147WnrQGHgYmpCgRQy1NC1R7cK3ksBDmz5VIXPschHA+3YqUzAHDKULsiKMgKUBczM/cnzTYESv4MuV9X4LnaqqOYtbmiWYD+FAQ22Xp2UdmZH4pywZBw/F2GZttV5TE356YoDEYw1V7L96YcCrrNYxZ8OZwzFliLRzfyny81AEqxqMT9xZK3y7CUUZOyUCEsEhreifFG6mSxjqgoUxlpa5MFfzSpBXZFnfp9uPZnOIstVevBFtSbaO3CTkTG4DJJRkLyzai3B+Z4qhZbJZ9Z7mhCj5Im+K3vjr6ycd2aZv/n0BOQKXtrNQRTufvvjKZNzDGWU9PmYaspD7aNBBSDO8pPC/g33HYRztCMf9d075pXlAmrHnuRsEaJ/ZatTheVGd9yYb3aWMlwFHKHhbI38nG/kLolMSgE45kjxzseRfmhGeyAL5YqGtFZ896z8KmuoJWUhL11TLVJjJF24S1PAO8dj20iBYBHN9zRlDVGM5+kB9fWHLoLzhDLwcZIsW2ZSGsNz9xykN30G65EzmTrPyLoDoEGml/m2exo9QBWXCWxM2QYikmPxFfY7Td3R6d33V0A6afRTJjemupkce3ifm8oDFHR6UmEJY9bScl9pFKp2pRqjWZ3JtYJryOrFntPK43dG+hGGnhhxFw0P0vT0v0gp74NlxyBGGk99LiwLsOF7GhXfN8InN3xtHdCBGEG4x0X4JR6+Rx6Dw1TXXzmsgAag=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(31696002)(53546011)(6666004)(6512007)(508600001)(2616005)(4326008)(52116002)(66476007)(6916009)(26005)(83380400001)(38350700002)(38100700002)(8976002)(44832011)(31686004)(86362001)(316002)(2906002)(6486002)(66556008)(966005)(8936002)(8676002)(6506007)(36756003)(5660300002)(66946007)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0ExbXNQV0hVcXJyVXkvVXFndldNY0J6TjhjVTRSejJSaGdSQ2g5Q25PbmlR?=
 =?utf-8?B?eWJTZThBN255YU1ycHowK3VqemNFNmpxMElyUUZWcmFWNDQvMnRxa2t5ZSs4?=
 =?utf-8?B?NWtyTkh6TkJLOUs0SFVQc1ZkMkErSGVCRGJGUFBnQXhMeWgrYXlxTU5yWUtT?=
 =?utf-8?B?L0wwRjZNbnpmOHd1ekxxSTdpRXRISTdBZUlJL1ZUZUtWdXVIUTg2MG5IYWNq?=
 =?utf-8?B?Z29FaWtVbENna2o5TEdrSHJaSzlaUXdBRSsxWm5CNjdYNEV5T2FuTkZsOWxo?=
 =?utf-8?B?c3EyT29nK2xGRzNhQ0NhQlBXTmZUM3JOL05hVVhCWHIzdEQ5SjhWc1NpekI5?=
 =?utf-8?B?WWp6WjdjWnJwWWdhODNSV3lldUErVFZhSDUvb2wwb2taMmplQ2NoQytJR1li?=
 =?utf-8?B?RFRvZk42bkJpWWs0STQwczZTZjVzcXdvekx3ZDNQUzdXMFBrOFdEK1hES1RC?=
 =?utf-8?B?TU9wcEZLcktsSCttanQ3em1nS3BtVllPMURzaUlXWTJkQzB3cUgxUmlqQldn?=
 =?utf-8?B?c0xpcll3dXAyN3hqZ0FSN0JOWkkyMHRjbUhLbGlzODdJbEJmRGhKVXdCR3dC?=
 =?utf-8?B?dFNyNVhab2hFS3ZTbHI1ZFVUVjUrRVFNWmZYUGF5dWpRY2FtRzFhemljZ0xw?=
 =?utf-8?B?Y3NDN2IydkVJRStiMXNySVdPM0o3cmRWSFNUc1hGMGx6Q05rbjlXZ2xkb043?=
 =?utf-8?B?S2EwckxYeC9XRm9mMXNwc0pVMy9jbXRSQllXeFlPUjMyUndNZ25rUHgrRlRP?=
 =?utf-8?B?VENZSlo3UGJPS2JNRVNkZlNhYWxPQ2tVL0FnRWt6SEY3Sm1DOVBqMFBEUDdL?=
 =?utf-8?B?aUJHSzA3ZzVMaFNmMkRHU1drRm9GSFpXOWdOTWQ3cHRhTkM1bXUvRGNGQlFa?=
 =?utf-8?B?d0ZFL3ZRL3pCaE16NG1xaGRMdUIrTmdsY1hlOXEwU2U5MmxQSndTYnM4MzBC?=
 =?utf-8?B?R3Ztdnk4YWx2MmJ5WFZ5NEJOZVdMMkZkY1NlWWtncDJUWFMyRXFGdnlHLzdG?=
 =?utf-8?B?bG4xcmpvYisvdXRBWW42dW42c3NTWnB4RzZQaCtTTCt0Zmk0Nm1YWGIxUEZT?=
 =?utf-8?B?TGNSWnFUR1ZjLzEwakxtN0E0dWQ4OE1ENXVTY0p5VjdQWGwwV09FSDYrcEt2?=
 =?utf-8?B?NkpVdG9DaTRDMi95bGh1cVMySU5JeVYvVFZRRUtCL2dSOEVMZG92NVBTVkhh?=
 =?utf-8?B?WnpUK29kS05ZYjNuREFmYkptbE5VN1k1ckJ6akJTR3Fxei8rVXdpOGpPdUpS?=
 =?utf-8?B?T0gxTjNIaDdMcmxNcnFiZmRBaDVLQlZoUGp6K1VGSGgra29nNy9zUC8yQmd3?=
 =?utf-8?B?NlZadHF4RU83R1lvQjBkZmZQWjVwdTkrZW5DclYzcFFRWW5MU3I2bC8rbG1n?=
 =?utf-8?B?QjNEVFRLNUl3RlZjb0dGbzJUNlNkdWxvS2dCSkFqUER2b2JQU1ZTRUpnY3dD?=
 =?utf-8?B?cTBhQ21RbE9sOXFmOEhGWUd3MEZhdjlYVXcyQUx3SWFLWGovV2IyY2l2Unlu?=
 =?utf-8?B?ZkZuMThCaS9KV1lKckEyRnRVY040ZFJvVjM2TTUzM2JUV2pibGlNNWtZM25Q?=
 =?utf-8?B?TmxEUkdVdEZPejg3eFpFejlKOEVLVC84S1RTU1RGQVlGL1E5V0dzNmdJYitt?=
 =?utf-8?B?ejBEdFYvdWN0VlcyTzBlM3F5ZkV3dFNXcDFLNXNrWEp0emFBSDZCaVNNbDdJ?=
 =?utf-8?B?a0JISFJkR29OZ3hOTkhPbERQK2oyaVBxNXRJL2htNHRhMHFOMmUrVytpZ0g0?=
 =?utf-8?B?T29DNkxwUy96Qll4SjFWTWE2Tk1IaE9VeXNZOFZ6YUk4bUFxUWg1aXJiK2Fr?=
 =?utf-8?B?R211NEFQSklWZDIrV1dRN1BzVHdvaXN0RFo0dWdaYUJKejR3WlNYb0FnZzVY?=
 =?utf-8?B?M1RUNUhzWXlHcjZDcm8waURzM0Voakp0d0xpMnpEd00xZ2ZBaDFWVjdtV1dP?=
 =?utf-8?B?c2JVY0ljZlFNVi9ZOUVlZmxHL0E2c0lRNnRFOGlSM3RYeVh5WTBWc1hsVW9k?=
 =?utf-8?B?aG51Tk9SMTFFaENBNjFhTUh3dlk3OEdHNXZtN0dHZERUcEJNVjl5WnNOMVBN?=
 =?utf-8?B?dC9GK1loQmcwcmlXV3BYVm0xWDg5VjRvOTJ1RC9xKy9oeXU2L09qT0ZtRFpF?=
 =?utf-8?B?enNJVzBIN0NLUzBLaG9MY2IvUHNvS3dJTFJtM3Vpd0lNOHlTalZITkpxTWla?=
 =?utf-8?B?WTFFd2JmcHhYNlQ1NnJkb08zenhreHprT1JBYS9ZaG4zYzR5eWdLU1dRSHBu?=
 =?utf-8?B?UERCNng2SEpXRVE0Z1Vvc1BPMTZlbFdwa09zazU5a3c1bDNEdHhxTndKc2VE?=
 =?utf-8?B?Uk1TQkc5MVVjSXRTWXlDU1Y3VFVqajdHQUhSbndORFdMeXR4V1FYNlRuZDRn?=
 =?utf-8?Q?OAnvRRVIhikbOEms=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d7550260-5dde-4ef0-69c0-08da4f8a6b4a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 11:21:55.2497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ud4YcY/hZPX2k8kXVLuTJrAa5iQo/JaftYQLNfrRs87MeUg46VHJMJnftONlx2xiqnlZznfC5KzDSpYEAMGVJYTPMD1zmHP8eFx/bBiJzYM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2490
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

[resending without image attached so that it makes it to the linux-can list]

On 16/06/2022 12.11, Marc Kleine-Budde wrote:
> Hello Rasmus,
>
> can we move this discussion to the Linux-CAN mailing list
> (linux-can@vger.kernel.org)?

Absolutely. Cc'ed.

> On 16.06.2022 11:13:41, Rasmus Villemoes wrote:
>> I have a board based on imx8mp with two mcp2518fd devices (sitting on
>> two different spi busses). I'm having some trouble getting them to
>> work.
>
> The ecspi or the qspi?
>

ecspi


>> A logic analyzer shows that the spi communication works (mostly) fine
>> [1], up until mcp251xfd_chip_ecc_init(). In there, it seems that the
>> regmap_raw_write() ends up trying to do byte-by-byte transfers - i.e.,
>> the chip select is only asserted for 8 clock cycles, then deasserted,
>> and asserted again for the next byte.
>
> What about the other transfers done before the
> mcp251xfd_chip_ecc_init()? Do the look correct?

Yes. For example the very first write done from mcp251xfd_chip_start()
-> mcp251xfd_chip_softreset{,_do}() -> mcp251xfd_chip_clock_enable()
looks like https://ibb.co/xMbdsSq , and the MOSI signal looks right (0xa
= crc
write to 0xe00 aka OSC, 4 value bytes, the 0x00000060 value in little
endian, and the crc partly off-screen).

>> Unfortunately, I can't physically put more than two probes on at a
>> time, but I have captured (clk, mosi) at one point and (clk, cs) at
>> another, and in both cases one sees these 8-clock bursts, which should
>> never appear with this device.
>
> ACK
>
>> Obviously, that means that the RAM doesn't get initialized, because
>> all the device sees is a bunch of aborted spi transactions. I can't
>> really figure out why this happens, maybe I'm missing some setting in
>> DT or elsewhere; currently I have
>
> Can you show me your SPI host controller node, too?

Yes, it's essentially the one from imx8mp.dtsi, i.e.

	ecspi1: spi@30820000 {
		#address-cells = <1>;
		#size-cells = <0>;
		compatible = "fsl,imx8mp-ecspi", "fsl,imx6ul-ecspi";
		reg = <0x30820000 0x10000>;
		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
		clocks = <&clk IMX8MP_CLK_ECSPI1_ROOT>,
			 <&clk IMX8MP_CLK_ECSPI1_ROOT>;
		clock-names = "ipg", "per";
		assigned-clock-rates = <80000000>;
		assigned-clocks = <&clk IMX8MP_CLK_ECSPI1>;
		assigned-clock-parents = <&clk IMX8MP_SYS_PLL1_800M>;
		dmas = <&sdma1 0 7 1>, <&sdma1 1 7 2>;
		dma-names = "rx", "tx";
		status = "disabled";
	};

with this in the board .dts:

&ecspi1 {
	status = "okay";
	pinctrl-names = "default";
	pinctrl-0 = <&pinctrl_ecspi1>;
	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;

	CAN_C: spi@0 {
		reg = <0>;
		compatible = "microchip,mcp2518fd";
		/* clocks = <&cdce937 6>; */
		clocks = <&clk_40MHz>;
		interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_LOW>;
		spi-max-frequency = <10000000>;
		pinctrl-names = "default";
		pinctrl-0 = <&pinctrl_CAN_C>;
	};
};

It's currently (for bad reasons) the nxp kernel, hence the
fsl,imx6ul-ecspi compatible, but changing that to the one in mainline,
fsl,imx51-ecspi, doesn't change the symptoms.


>> 	CAN_C: spi@0 {
>> 		reg = <0>;
>> 		compatible = "microchip,mcp2518fd";
>> 		clocks = <&clk_40MHz>;
>> 		interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_LOW>;
>> 		spi-max-frequency = <17000000>;
>> 		pinctrl-names = "default";
>> 		pinctrl-0 = <&pinctrl_CAN_C>;
>> 	};
>>
>> with the pinctrl being for the irq gpio. I have also tried lowering
>> spi-max-frequency to 10MHz (currently it ends up effectively using
>> 16MHz),
>
> The driver uses 85% of clock/2 or spi-max-frequency, whatever is lower.

Yes; using 10MHz was just an attempt to see if using an even lower
frequency than the maximum implied by the errata (and implemented in the
driver) would make a difference.

>> [1] One thing I have noticed is that we probably want to do
>>
>> -       xfer[1].len = sizeof(dev_id);
>> +       xfer[1].len = sizeof(*dev_id);
>
> Fixed. Do you want to appear as Reported-by in the patch?

Yes please.

>> But: the reading doesn't seem to work; it's as if the device doesn't
>> drive MISO at all at this point, because when I configure the pin with
>> a weak internal pull-up, I get 0xffffffff, while if I use pinmux
>> settings with a weak pull-down I get 0 - which is the "correct"
>> answer, but probably not for the right reason.
>
> The device id is read after detecting the chip and the
> mcp251xfd_chip_ecc_init(). Does the chip detection work properly?

It appears so, adding a print of the osc variable after the
regmap_read() in mcp251xfd_register_chip_detect() gives

mcp251xfd_register_chip_detect: osc = 0x00000468

so the LPMEN bit seems to have been set (and the other bits show
expected values). And it's true that the dev_id is read after this,
through mcp251xfd_register_done(), which is why I'm puzzled that it
doesn't seem to work.

Are you sure about the ecc_init() part? AFAICT that's only called from
chip_start, which in turn is only called when the device is brought up.

>> I'm on a 5.10.y kernel, but I don't see any commits related to this
>> since then (other than the error handling in
>> mcp251xfd_register_get_dev_id()).
>
> Which kernel are you using exactly? Mainline or freescale/nxp
> downstream?

Currently NXP,  lf-5.10.72-2.2.0 aka a68e31b63f86. I'll see if I can
manage to make a mainline kernel boot.

> Have you enabled DMA on SPI?

Not explicitly, but nor have I done anything to disable/not enable it,
so I'm not really sure what the right answer is. Is that a CONFIG_ knob
or module/kernel parameter?

Thanks,
Rasmus
