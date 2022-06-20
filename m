Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB62551E82
	for <lists+linux-can@lfdr.de>; Mon, 20 Jun 2022 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244768AbiFTOW0 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 20 Jun 2022 10:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345553AbiFTOV4 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Jun 2022 10:21:56 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130112.outbound.protection.outlook.com [40.107.13.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508261E3F2
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2022 06:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG8nDnn086Vktu4L2OiJAQcZ5wNSpUaNNR/C334F1kBBCtIopFYVN/MOQB5drXK7KxXoLYg32+wPwQQHwuu1545oXJ5LVMmctVEcDMZOSMLyA5zW+ZtwBDFw0vjs8L9xV6dWdSzV/4NOMf4KurC/RjvRJDH3Z2xF85Sm6CoMAzaf3e3VpnBKbY+Mbu6An62lD9oYHaJuxbsYOGWoIbChqwmBsx+HXPA710UC/eKkDDunmWGlxAoA3adf2w9ZS48abJdBcMq3rGQHodHRjK7aIXU4Jw7F52HIeg5L3uvf4eoOVSqQG2Tzi9yt65EniMkGICMUREv04gYjak3IBOBffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84Pt3pMWXe6SZ6My21qYZn4H/N0882NIUnrT0GLtN8I=;
 b=cHynd3aV7sUW90dssJF6dPT794hy2FoIVTNfBa3O/npprzLZLDKkqNRzBstYY4Pv03kGIaEFd+y9Igwe1f5001FvVDJ8VUcTioE5wm+mxGKHwC3AZ18dh0IujiXXdAllKOgr7n5Kc4pWkKKlkBr+4/vReRjJV18uhUhZrWaWTgEAizbO/n/0JnJxp+vRqmJdjBo288fPu55YlcTkAld0eahvy7f4DhDGy2cDxB/qrMRYGRRVK9UWxDVhV9m3oUT4VzuEJo690x7CrAffjsikSmiVrwyz1mRMdTcy9awR/wKm6MRCAK0R8Sk9jJuXlRYfJ7SZTCTEUl8XI/0TT8/Ebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84Pt3pMWXe6SZ6My21qYZn4H/N0882NIUnrT0GLtN8I=;
 b=AUJTXJfPYlh6JKIzijAQgw3KlFbesD7fXKRz0e9Mhd9cHyUUvaoK3tD98WoLfnc6TGKFnBS/7U+BXeBocACiV+Q8iwp5Ffi2lUcPCZgUCug7DMcMyCfFpNFbmYBYuFyH2hmGzS4onj3aP2UNlFuKv22NmW21dFn4A7fgrf/yQMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by PAXPR10MB5591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:243::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Mon, 20 Jun
 2022 13:36:38 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8%5]) with mapi id 15.20.5353.016; Mon, 20 Jun 2022
 13:36:38 +0000
Message-ID: <3da42c74-66d7-b41d-be7f-87ce687f99b8@prevas.dk>
Date:   Mon, 20 Jun 2022 15:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: ram initialization on mcp2518fd
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
References: <e3f73c56-1b46-4ee9-357e-40400c746e09@prevas.dk>
 <87wndgyl2l.fsf@hardanger.blackshift.org>
 <441514ec-7b43-e11c-09b5-bdaf7fca0077@prevas.dk>
 <d614f497-b8f2-68cd-745b-1e3be2b991d5@prevas.dk>
 <20220616124056.cnnvlqwwkknjta7w@pengutronix.de>
 <8db56a87-a1c7-1810-ad74-c7a8e268a00d@prevas.dk>
 <20220617141751.ua3emcdaarrnx7si@pengutronix.de>
 <6e01d1e0-4e26-c42f-5d8d-f5aabe0d9d31@prevas.dk>
 <20220620102732.uou37hhhbaspgmb3@pengutronix.de>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20220620102732.uou37hhhbaspgmb3@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0042.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::34) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37860cf0-8ce1-475f-1e1e-08da52c1e6cc
X-MS-TrafficTypeDiagnostic: PAXPR10MB5591:EE_
X-Microsoft-Antispam-PRVS: <PAXPR10MB5591944D38A37D1A25FC87FB93B09@PAXPR10MB5591.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LT9bnGSJ9agJtn9gIgFmlnmXlMKxxjdd1V190c3f0V82dyFlnUvsb1VPLwsEqmDq9AOdxRtI8MvjfAdl1qCGKySxbpFjzd+68bURn1NmpruKsQmALBVWmDKnBnct2YQ2xZe/IpFkhFQimBAsAL+p7+nONgUwHoTlTHHs9jMnG/BvGxt7Ux7LGjcEPWvAYuGiseLGTldYbnL+MQ+Il0R1NOLiP7nfcjAf+LVCrhTFRFSh+h98ZlOIFURiufnGjT/mwWBOB1ljwAyHWSBaTTH1GBneMLbP/zloRGc4KgVnSypeEP4pHKLOSTsG5j3Pd0GtcLoLArfRNAX4ew5vXvWb8jkS4RPq1VsvGaPTgXxUMbCmBwbsainewtSKd8U4Q9vO/zObZhrcbaqZPh6dMlAPf18qCEQMmkbs1pN148nXsmM2tIyNvhj6bGLmBu6peyPY0CMIEsdn1mAaU8cUK7zFld8aeOVHQsjuEA6gjFVu0iMCjnxosVU2EwVbWkBj2ZzCp4bq2UayrtxC0b2moYADzQYTqc8qxfGKnrstRxhHx9PJjAdStcrCL7UKsL7ciE9e+sp8hZZbDxiBufxyK1+EruFX6SETyhkhNYURG/mofwQLBB5aBdmvJ8XiKCrj5anmfweJ/6ofHHrL2eDPVqfAVzEC/yYg6HOOG9+JerQ131SxGycKIdNG5IooPyuY51Z/mbPUSPqyKWSINjgVAXjTLKVSorWbvSVkE+Duc/oXk5KNztFXp16tcc3dqRozMD+cQuFjlyKC0GwWEanpnbeSacF/vEe4K6bmsYJk9YlMpK8qZ9ld038N8fnbNRU57C7B1+i51EXpT3qIAvOkYM2pzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(136003)(39850400004)(346002)(366004)(376002)(396003)(478600001)(86362001)(66946007)(66476007)(41300700001)(31686004)(66556008)(36756003)(316002)(8936002)(186003)(6916009)(966005)(8676002)(4326008)(5660300002)(44832011)(31696002)(6486002)(2616005)(52116002)(8976002)(83380400001)(53546011)(26005)(6512007)(6666004)(6506007)(2906002)(38100700002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGFZQjRzYjh1WUlFMmRGK2tLSHNDb1R6TS85Vk1qUTJHZW4wZk1hN1d0VjNG?=
 =?utf-8?B?dEtLdGw5aW5jY1hPdHlVUU42YmQreWY4T2pjSDBVWnl4aGliWlBkZ2NOQkhU?=
 =?utf-8?B?ZWgyWnBLbW1tcG9sSTY2dmxnS25qbjVUZXFFbktINndWa2Y4Vm5LN2V6aXoz?=
 =?utf-8?B?Y0c5NHowTlVDZlRnOUxQbnc3OWI4eWg4eHRVK3YySWZ4VG5nVlUyY1RBSmtX?=
 =?utf-8?B?Tjg0NDRXNHZsL1pBaVkyZElyR2dXS0g1aVRTUXpYaWZvWjdRZHJnaVdqaytJ?=
 =?utf-8?B?cXVEdDV1SGRHSGJCOGkyQzhpVTAzTFRlN3oybUFEYXk0cTZ3TXdmYkZIYUdv?=
 =?utf-8?B?YWpYdGpPamhWWDlscHBIYjk1Q3ZmejBhWUw2WE55Rm52eUNZK0Z0SXBiUVht?=
 =?utf-8?B?TEJtRjBhRDArN29la3RoekNKYWttZ1hWNlJWYnh3dXFYU0ptdDVSWFlUeXli?=
 =?utf-8?B?K1FkNVdVMktqajRoNjNXTVZDdnlKdy9UbElGaC9JcnAxS3hIOHpUQk0yVWFq?=
 =?utf-8?B?ZnQ1R1ZOTndKYnhIdVlvYkhEOVJUblNvdVBmSjA2NUlwTXlxTXZRZE54elB4?=
 =?utf-8?B?aXhrRlRIbzRTM1NnaWU1RXB0RUd5Wk9NNXA4UHRpK3VpNENFckJTUUxWMit3?=
 =?utf-8?B?WFpSNFlQcHhGZTEwbHpxblhsQ3I0d0FEMXU3aFQrcHlFMDc2ZFVNZVFDRWVh?=
 =?utf-8?B?a1pwWUZObHFPQUFNeXBteXQzVTQ4eUNzdk9CQS9VVzBjM0FkTFhMSkpWdzhJ?=
 =?utf-8?B?dk1WM0JoRGQ3TGpZbDlkNzJBWnUvTzFuL1VKUkd2MVRDQXc5MmtSUjdEdEhI?=
 =?utf-8?B?dmFuRlFVSzNwZFdkd3U5Zy8yZnhrR0s4dVA4Y2VESE9Dem12d3NXL2xzcUhp?=
 =?utf-8?B?T29Ea1VUb29haFk5NTQrSC9qeFArbnh1OWdJMDNsT1QxT21JbmwwVXNVaUFN?=
 =?utf-8?B?UkNyNHFCSXZENk5LWTlJT1ZPejVqcDF6cGtRNVRWcTdjd3VjVm1VZ216dkpK?=
 =?utf-8?B?VUNnaWQ3eVN3ckh1dHJkTzNuZkJqc2JRRDlpK0RVdlh0dnAvQVBlYlc2d2FB?=
 =?utf-8?B?aEh2d3pVTnZiMFlaOFBHV2lDTnJ2V2hvZGM3TGdidllWMnc5U2M2S044Y1l1?=
 =?utf-8?B?SFVJQVRkRWhzS2JZSlhtUGFZVVdrZFZ6Vkd5SlIxb3pxYUU4YkxDdnFsdmJi?=
 =?utf-8?B?M0RRaHVTY0ZoSDk2bnZiRnByMmlxODE3UDFSNkNpMFdmQmduQm1YWHZ4SkZU?=
 =?utf-8?B?NUpmZXM1QXBubUpoL1FDK1UwTzlqNG9BSTVYcFhaaTQ5dHFFemExM05YR1pa?=
 =?utf-8?B?SXNZNCs2SU9mRGpad0RSVWd6QXk0a1JpQ0w4aDRXV04vMEJpV0wxeXFJY0p5?=
 =?utf-8?B?OXREWW9RY21RUmlPWnlPME93TVpQaXlMSktTdWo1M2ZTYWN4NUVSOUVlb2xP?=
 =?utf-8?B?Z0padzNNUG5rK2kvdlNXMXhtZEVkY0dFak5tQXV1Qi8rdzhFU0psUVc4Q0xC?=
 =?utf-8?B?MmxyaFJQZkFGT0NCSHQxT3FLdEp4TkYxNWxxZmxzVjI0dnpDdXZzK2tuTXFG?=
 =?utf-8?B?N1dtYm14MG9RMG9uVlRsUmVXemFPQjNJcTFtU3NyTHZwTmQwRy9xRVFEMC9Y?=
 =?utf-8?B?b003em1PTytSZmZCOXFlODJLd3M3VS9BM0xTRnFKbVZXYzR0K0JpbExSL3NM?=
 =?utf-8?B?Tm9RL1JkRDlPRDI4TFNmUDNpaHVuQ2lvUXI5VnROMmFyWWNUVnVNdTYySDNZ?=
 =?utf-8?B?L3FqVkRvQUtock9TRFJoUzJxc3lqbU1LVndzcmJudjI2cUI2ZUEvWkMrZjBV?=
 =?utf-8?B?RkIvYk1jK1J3c1JXVTFvVU92RFRIS3dzMW8vRXdmaFNLUkhFUEt3Q3lrZmVl?=
 =?utf-8?B?NHgyQXlJTDRjelNBdnRjcGJaSFJaUWxER09vNEZHYUlydUdMQTR1TXJSQWQ5?=
 =?utf-8?B?OFhseXZweFRiY0hJQnZBOHJ1U2ROdUtNOFNlWDJqQ1JvN3RzOFNUZFR2RnEx?=
 =?utf-8?B?eWhrZVBRV1h6dCtoaHlNMzRiK0xQK01SeHhPOVk4aC9Ca3RRYW1LeGtIdFlI?=
 =?utf-8?B?SjJjUHNYdkxEQlkvOHRvcHhGaks3NGlPZUlualJhcWI1S1A2ZjViSDNZc211?=
 =?utf-8?B?c1dEMDlYWEMrL1BoY2dyKzFYcUpOMHFzU25jdExvYkNNMjZvZXlJNTJpS053?=
 =?utf-8?B?d2NEZVdxRjNUcm9nR2Zsb0tBbFpBRE5scUlUN0hJdGlkekl1UkRpY2N4M1hO?=
 =?utf-8?B?ZmNPUm9uakVPRVZCZDlad0VYK0ZSWjJIOUpMaDNEMHVkMWNuV3B0amhXVFkx?=
 =?utf-8?B?eEtLTjgzait1SG5PamxLMUFzRG50QUZOSHZvUVpXaFQyWHFsdXpaV2NFUFpP?=
 =?utf-8?Q?cVz8tP0TIuNCvqMM=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 37860cf0-8ce1-475f-1e1e-08da52c1e6cc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 13:36:38.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JybWW4b0CWJL4koSDXNgciSVcB981++LN2aUMT6lLbCXriaVv29Z80SwdDrpFXBIw70Hx1J7xkXzA7W1DESqkHZiwa6jS0rgcbTek+bCnTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5591
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 20/06/2022 12.27, Marc Kleine-Budde wrote:
> On 20.06.2022 09:09:09, Rasmus Villemoes wrote:

>>>> when I start the traffic test. And the dev_id reading still doesn't
>>>> work (though it's not really used for anything other than an
>>>> informative printk).
>>>
>>> What does it read on your board? But still that transfer should work.
>>
>> Depending on whether the miso pin has been configured with a weak
>> internal pull-up or pull-down, it reads either 0xff or 0x00 - and
>> that's also the case when I expand the read to all six e00 through e14
>> registers. So the chip isn't really driving miso, and I think that's
>> because CS is released between the two elements of the xfer array.
> 
> Can you do a measurement of that MCP251XFD_REG_DEVID transfer?
> 
> For testing I read the OSC register instead of the DEVID and print the
> value:
> 
> diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> index 537335d42d1d..79de59f9c145 100644
> --- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> +++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
> @@ -1796,13 +1796,14 @@ mcp251xfd_register_get_dev_id(const struct mcp251xfd_priv *priv, u32 *dev_id,
>         xfer[1].len = sizeof(dev_id);
>         xfer[1].speed_hz = priv->spi_max_speed_hz_fast;
>  
> -       mcp251xfd_spi_cmd_read_nocrc(&buf_tx->cmd, MCP251XFD_REG_DEVID);
> +       mcp251xfd_spi_cmd_read_nocrc(&buf_tx->cmd, MCP251XFD_REG_OSC);
>  
>         err = spi_sync_transfer(priv->spi, xfer, ARRAY_SIZE(xfer));
>         if (err)
>                 goto out_kfree_buf_tx;
>  
>         *dev_id = be32_to_cpup((__be32 *)buf_rx->data);
> +       pr_info("%s: reg_osc=0x%08x\n", __func__, *dev_id);
>         *effective_speed_hz_slow = xfer[0].effective_speed_hz;
>         *effective_speed_hz_fast = xfer[1].effective_speed_hz;
> 
> And it gives me:
> 
> | [  171.051636] mcp251xfd_register_get_dev_id: reg_osc=0x68040000
> 
> I just noticed the register contents isn't big endian, it's little
> endian. I'll send a patch. (The address information is big endian, and
> mcp251xfd_spi_cmd_read_nocrc is taking care of this.)

So the problem was that I was using native chip select, i.e. my pinmux
setting was

MX8MP_IOMUXC_ECSPI1_SS0__ECSPI1_SS0	0x00000144

and that means the controller only asserts the CS line for the duration
of one burst; so when the spi message contains two transfers, it
obviously breaks as the device saw the release of CS after the two
command/address bytes as the end of the transaction [then, from the
device's POV another begins, but there MOSI is all 0, so that may get
interpreted as a reset command, or perhaps it's ignored because it's not
precisely 16 0 bits - I wonder how the hardware designers thought
all-zeros was a good idea for a reset command].

Switching to gpio, i.e.

MX8MP_IOMUXC_ECSPI1_SS0__GPIO5_IO09	0x00000144

means CS is held low for the whole message, and I now read the expected
contents.

====

It's probably not anything to do with the mcp2518fd driver and this is
straying somewhat from the original problem, but I see that CS is held
low for a very long time after the last byte has been shifted in/out, on
the order of 0.5ms. https://ibb.co/n1Hq3YR shows the first write to OSC,
and zooming out shows https://ibb.co/12Z1YkM (or just looking at the
mouse-over info in the first one).

Similarly, there's a rather large gap between the two spi_transfers in
the case of the reading of dev_id (but, per the above, with CS correctly
held throughout): https://ibb.co/pyG1y96 .

I'm not sure if this is to be expected.

Rasmus
