Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B04563810
	for <lists+linux-can@lfdr.de>; Fri,  1 Jul 2022 18:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiGAQgx (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 1 Jul 2022 12:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiGAQgw (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 1 Jul 2022 12:36:52 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70095.outbound.protection.outlook.com [40.107.7.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1983D3FBC7
        for <linux-can@vger.kernel.org>; Fri,  1 Jul 2022 09:36:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irH4g8GcETxWeFVlJw6HV92AaJEKifmdbM/XS93g2uVRNYv5kBbZmOp/EmGhb48EBxX1D7TvEC08cWqaTAGXUFSHuS9HwoSeuP+51kUPeg7nxLF8+2UR1ODeb1qZ9wFrt1CEcbdKcrjSuZCJ2B3blen8rNEsb7hBVKNKFwdSvKl4c1X8geUjQv+/iLPFByJ2seI+3mF5np0TLPnCYv1EUsDBYtpTAGpv1IDqltm5gYlMc2Dv5H5+1FqZ6cEuaSYWeD6+oMUs6FrYEcSk0LdKoQ8t9w4S4V84uA4Z2EpBU/zPFgmKOGh6PFK407jJtDuMTHe/KTJ/WZUKhm8NA6x/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EK9j/YdvikRbc0+gMmhRZd8cwJUZfItFlc3UN/2vU6Y=;
 b=g4JdvRil/OLArSZqSppGxtt9P16PmOO6QJ5zTAogsKSrhgSc0aSzMxGbfkylbyKyckX2cNFq5f6Z9auXzy0yMm4+L7MeV/4Nrfbfr6bPveDNc+RaprAy5MXJ004IXl2Ee/KP8dksy3iUA+VRI4cFDSOpCHaRUToXd0pXvVcyDDRElPvF8z57QVjPyHIvisaykYx/qwAnyvcznwuqO+J2pIyyR8N/f8ptKnjjjLxArVRAw5kAoFMhqv2GJei8kMbH9+skhXoNmKihiXzBdbM1AYu199YRgH834kOUL2oBYIH7x5q6w6OavUR9n2nk0ETN9slR9lGXoGgPcOI/RxLrMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EK9j/YdvikRbc0+gMmhRZd8cwJUZfItFlc3UN/2vU6Y=;
 b=GF1UTgpiVKmuborlCMwgE7M1hCUiODQHWeUkIqB2jMqHB238A1SL6UANB4lC5zN3oHNeY623y/rOKWyIxupgwPyrGMzcHwtS5mWUvcRdyC5cpJV8WtlF7SOUy7+9hV7or2JQB3Gpog+aiEumVNy5GBMSLcWAXAbUkCdEtLMi65E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=victronenergy.com;
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com (2603:10a6:10:30e::14)
 by AM6PR07MB5687.eurprd07.prod.outlook.com (2603:10a6:20b:2a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.8; Fri, 1 Jul
 2022 16:36:47 +0000
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::254a:8d7b:3cb5:7306]) by DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::254a:8d7b:3cb5:7306%8]) with mapi id 15.20.5395.014; Fri, 1 Jul 2022
 16:36:47 +0000
Message-ID: <cc2e57b8-5b29-11b8-aa7f-fea7ac96d68a@victronenergy.com>
Date:   Fri, 1 Jul 2022 18:36:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 00/12] can: slcan: extend supported features
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org
References: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
In-Reply-To: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::16) To DB9PR07MB8679.eurprd07.prod.outlook.com
 (2603:10a6:10:30e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08005ad3-39d6-4368-bd89-08da5b7fe3f8
X-MS-TrafficTypeDiagnostic: AM6PR07MB5687:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5M4sro2HXDTxSk2bV4boqemma88irxbdidOeOEhNVyyalk17D0KHCQGIez5P6L75UDmVAgofaWdobHnhCld3BIHosutiNbPeLewI7b4gLL68MLlovafL/6LIqY3zdK7ScrdX1O0Hgziz3ymG1xtZkk8pUwQwdew2nLR0u3Q+kq/nkMRtQ6ymULVvcyfc4jhQGGSG1Y2tBGxU6bNyBxpY3b6wdI/iLjC3XNfiL/QyMHyt6d+TUC5VN/rgslGq3/Jcam+MK+Ahs3m/IvysKzEv4s8B5+C5y8QNC8GQjUHE4FI7mw3GBLTPGa4iXKD5LmzJ4bph6YsFOi4fmT3TKoo2j6GkNQ60ugu0nKjTB/R+mqndzC/YCuWgSfzkqqX/nv6DT77wLL7zKtjI00/3I3cLj4IIw+3Q7p0z/XdGTWEPSS6vIQtllk1zYEA8vecdOZsE3MHlhb/jApyFbjmyMRrg+mJ3ihXilDqlisFR8QaAoplzZOmiQZtinTgnaxsCe5FMVxHecTQxWdhRzKtwsnr/25uwJWHUi1T7OXJzM/ATd8BFdRTBtvqd2uIVfrYwKGsojCRuhOOUKrVDhFTjecZz4w/Z/Jb259zXMPo+atESYYag3HkPl78sEAZL7YFAEU1a2u97vS4ck00Yi9ML2y64sv/1nP7eSwqE/gUBKhOswCpSlg7GuMpc9en48YT7WiX8dJpgTd/BMfAJCYxvGhSLOmRygxTG8BtxGGSV6KgI5B/pHFt+knncbTJtKwNF/C4S+yt8pej1Z41Q6bbDJVIScgr+p8X6IbPM5hOU/KF2iMgwp5ZiJ6Urn78iVRR2awSXokfgq0qVWgw7Yt+4sbPlTAPzIbstGgZncC080os4ljC+1W6lnkx6FqIdofITlSc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR07MB8679.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39850400004)(136003)(376002)(396003)(2906002)(41300700001)(54906003)(66946007)(86362001)(31696002)(6506007)(2616005)(66476007)(8676002)(186003)(31686004)(66556008)(4326008)(38100700002)(316002)(6916009)(36756003)(7416002)(478600001)(8936002)(5660300002)(83380400001)(53546011)(6486002)(966005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RtVlVUKzBLT3owbjRXUUwvRDhEZU1CRXR1bFhxSHFnclc5akRldmoxSi9k?=
 =?utf-8?B?WEpzb0tTaWNWUzVSZ0E5OUxCZ1FpVG11Ti9ZeWdQR0FvczVOVEhReVlRYWtO?=
 =?utf-8?B?NVVGSVlNdmNUTEdSQ2NZUDIyWEVwOHJ0RzZUajdhNzJWYnovVFJUNVVXYXEz?=
 =?utf-8?B?YjJVdEZVcFRaRXN0QzBRL3pyeEFDMjdDN3BWdXlqdHVwbGNyd1h5M1JGQ3Nx?=
 =?utf-8?B?VHZJSmlmWjY3enZJTWU3d1paeTdCKzJ0WlF1Ykx4NXBYQ2VwMVJmeVpEZklv?=
 =?utf-8?B?ZVlyMlYvcDYxU3NRQm9mOW5lei9tWHNzaFM1QjFZcXRoc3FqNGJJMjBBTTNL?=
 =?utf-8?B?bktvaHZiNytYUW4zcEJZZFoyR25EZXR5UHZ6eFBmWGFMZmt6S0dJRzc3WEU1?=
 =?utf-8?B?VDJtaXByMmFrVE9FcW5yQmFtMnpUQ1gySEVUalFEWDFPK2ViQjVxWXhZUEp2?=
 =?utf-8?B?djIvdFovSURwOTZjdHpWNzFrTk56OEtSVEJGRk8rMzNweFFPc3p3MUtsU2pu?=
 =?utf-8?B?RlZnWXp6dkdYWEpXVXNTTzdIOWp5YnpjVXlXR0Z5T3JHdGh6K0QwU1I2d1lq?=
 =?utf-8?B?ZHozb2dwcjFWMVQ2eWpwNS9keXBLTDNzM0kvQlJMWm9Cc3BydjBtQ3ZPNXdi?=
 =?utf-8?B?Vk9MU3l2Y2ZlcU0veGZzM0xyaEhad2w4eFMzUmdWU3dUdi94VGJ3b3VYN0hI?=
 =?utf-8?B?NzVIcjVjZTA3NmI5NmZKZDZGMFJQUXFhd0tWNXdGUEhQVUlVaTEvd21TeTE3?=
 =?utf-8?B?WkNvbUI2dlFiWVlSdzMxeHA0MHozc213eDk2ZExlekRua1NINkNraUNQNm43?=
 =?utf-8?B?ZndxUHUxOGY2S0duRm9qOFRoUWJsbk9qb1BDR3l6OVN4eTNSdUt0M01HdkZI?=
 =?utf-8?B?S2ZKTERvdGpLcVRJc3BKeDRsRWNRN1k1b3JZbklJZ0VJNER2VmRNQXZxbGVy?=
 =?utf-8?B?TlQrbE1sOExXNS9EcHE3WjRHMkdkV0VubDByVElrZDRpdDVJeTI1eVMvUkVk?=
 =?utf-8?B?VzR2anNFMjFoejhKSmtDbFBKS042dFl3Sm9DTFY5WThWZ0JDbnh4SzNKRkIr?=
 =?utf-8?B?RU1iWHRXTVF5SWJzOHVaVWk5YzlyZFpFQ0dxM2N2Q3crRUdDU0tDclhUaVI0?=
 =?utf-8?B?dVNqY081YUZKc1h3UkhUSEQ4UUV5VjhZU0JLaVpHUklvYnZpaFdBY1AyN1oy?=
 =?utf-8?B?dU5aczJHaHQ5ZWZaU0lSc0RCOVdGaTNpTVh5cEk1L1FualNycmcvOWNuaEF1?=
 =?utf-8?B?OWI2WEd5dnR6UjZ4RDhySmFIcTFVYnFqa2R2SmYyVlFHYjdESGE1T1F3dVdD?=
 =?utf-8?B?SVgxN1F0Y2RqZzc5OUdVaUY1dVZYRHBxbEZ6M0RjbmRZRy9HZFVmTllYZVFv?=
 =?utf-8?B?ZUp4dndwRzExTzdkQm0vTlIxTDFYUlVMbTBHWkdkNEh0a1BPMnloWFJHSWk0?=
 =?utf-8?B?ZDBwWkpmUklKbmdzS05WdGhGTTFBbzd1Tm9EVXJqNE9MVDhVclZmbWpuSVFK?=
 =?utf-8?B?N1FtUlhFeW1XakcyUGsrRnZEVDE0bWFkT0RGRXZLUFh0Z0pwWFMweEdEV25G?=
 =?utf-8?B?T3FuYmltU2xCZmJDV2d3aXlCbWdKRnliWXpQd2V6K2tYSEZOSHpyL1ljNk9l?=
 =?utf-8?B?MGV1bjBLU1Q5aXZZUFZMRnFIQlNYM0ZzSnEvMGdXMitQKzhXTFdzTnRGcVhw?=
 =?utf-8?B?azhqNTRWc0tCODVvV0ZnYkR4RmNnMUYvMTlXRFFBVGNCNzloc0hBT2RVSEsw?=
 =?utf-8?B?QU5PLzR4SkFjWFROb2dzS3ZHdlNaVURtMTFsUXRxbzJBb09zT3ZpUGlpL2FM?=
 =?utf-8?B?VEMxRE9ZT0hQblNXWDh2YlU0UW02bldxdXcydEdIU3JFd3BqTUdUR2ZUNWx3?=
 =?utf-8?B?Z1hGakRhYXMyVTI4TjlYVnpTeW1kRTVXSFVnbVBpWnpWWTYydHdwenNLVlNT?=
 =?utf-8?B?RVgvb0RBRWFXRElJWERNL3VMRkRGbGFYWVBFUkFaZmJXSW9ZQWo3M0sydzhp?=
 =?utf-8?B?TDlSeHVXVlBzc21JUU9oaXVJcjhhcVBxc2djYTQvZStRL0tzZXNBaGs4bW9r?=
 =?utf-8?B?M3NnNm1RR3pobTVzUk1wWEhrYWpEUlFJQm1nM0xkOXdDVDNoczRNVUVEelgr?=
 =?utf-8?B?cTRqN0h5RXA0MzZvSENsMVBoU1NrczA0WUFSZnUrbHUwM1pZY3NrYkYxKzN5?=
 =?utf-8?B?MWh2TVVqV0t4b2FwUmtoVmpQZ1luT1JGRzRIcUVYUDZZUmVyNzNVWE5oTW5l?=
 =?utf-8?B?a2lzV1lqaitVSkoyUVJIYkQweXdBPT0=?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08005ad3-39d6-4368-bd89-08da5b7fe3f8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR07MB8679.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 16:36:47.1612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWMm3o4Z9X+uvUvIuS5EeO15iQqF4aonHVE3vLySh1csJh9bABQXk5eTZjpCA6nTgZ4H4si4Tdn8GkFp5tkevLV4EW5mVTyguqHsYooV+s8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR07MB5687
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Dario,

On 6/28/22 18:31, Dario Binacchi wrote:
> This series originated as a result of CAN communication tests for an
> application using the USBtin adapter (https://www.fischl.de/usbtin/).
> The tests showed some errors but for the driver everything was ok.
> Also, being the first time I used the slcan driver, I was amazed that
> it was not possible to configure the bitrate via the ip tool.
> For these two reasons, I started looking at the driver code and realized
> that it didn't use the CAN network device driver interface.
>
> Starting from these assumptions, I tried to:
> - Use the CAN network device driver interface.
> - Set the bitrate via the ip tool.
> - Send the open/close command to the adapter from the driver.
> - Add ethtool support to reset the adapter errors.
> - Extend the protocol to forward the adapter CAN communication
>    errors and the CAN state changes to the netdev upper layers.
>
> Except for the protocol extension patches (i. e. forward the adapter CAN
> communication errors and the CAN state changes to the netdev upper
> layers), the whole series has been tested under QEMU with Linux 4.19.208
> using the USBtin adapter.
> Testing the extension protocol patches requires updating the adapter
> firmware. Before modifying the firmware I think it makes sense to know if
> these extensions can be considered useful.
>
> Before applying the series I used these commands:
>
> slcan_attach -f -s6 -o /dev/ttyACM0
> slcand ttyACM0 can0
> ip link set can0 up
>
> After applying the series I am using these commands:
>
> slcan_attach /dev/ttyACM0
> slcand ttyACM0 can0
> ip link set dev can0 down
> ip link set can0 type can bitrate 500000
> ethtool --set-priv-flags can0 err-rst-on-open on
> ip link set dev can0 up
>
> Now there is a clearer separation between serial line and CAN,
> but above all, it is possible to use the ip and ethtool commands
> as it happens for any CAN device driver. The changes are backward
> compatible, you can continue to use the slcand and slcan_attach
> command options.

Many thanks,

For what it is worth, up to "Send the open/close command to the adapter
from the driver.", I cherry-picked this back to 5.10. That seems to work.

With kind regards,

Jeroen

[1] 
https://github.com/victronenergy/linux/compare/v5.10.109-venus-5...victronenergy:linux:v5.10.109-venus-6?expand=1


