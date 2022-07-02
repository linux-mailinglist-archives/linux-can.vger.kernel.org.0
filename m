Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AEC5640D5
	for <lists+linux-can@lfdr.de>; Sat,  2 Jul 2022 16:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiGBOuG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sat, 2 Jul 2022 10:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbiGBOuF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 2 Jul 2022 10:50:05 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2134.outbound.protection.outlook.com [40.107.21.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4284ABC0B
        for <linux-can@vger.kernel.org>; Sat,  2 Jul 2022 07:50:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8kqYDG9xtY7Q7uHfysKY4mJIwUq0Aq5InShjrmc66PZXF6weUCZdM3EMtvekGuAxqK2dyn7rCm0f2UnKOZS+drCv2hdStS40iAjGfeqjv7wYMW6SvTSnyC4p7WFKa9wnKTPxuLVlT15sBWiOdinp26ZAoMIfYN4r66OuevH1jL1+wCD/pcHatoMpblpOIEkk9TVETWWK58htyADARM5AruhmTjypJ1zbYIR4R5EJngGoAJa+8RglaUdl7q89n9fhrCjXbwW4XZ1mgGOcB2zeljo+wThiLHr+iuNg5CEL/JdEPbd7utZBroVwuP+AI+F7YXfO47Y9FSTfbeZlGUqWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SiAfqdxrUuMPki6oQw142cO2GRmXvP58QDdy86w+Rk4=;
 b=OZ6UiO3Sn/PsYOjByx+5hsLYmssb6tAwQfzAjIdad9CUmeIjwNg97Ls6iCEougnnEW3GAhIhzC1bKbGN8V/qAHaBFleE39GJ6VfsKzHAcqtxH0CmDgfP8FrWVmAq772ed1Qs4VFmjuNlx6fXEw2pT0GAf/8h8Fz09OWgHvKy4wNfu/3shGopj8d42//Nk4z7/NHhr4+4uNIGC6UJ+fzgYSJfUdViwZjShcMpxn3pQ+XBhHciTJLvqBcotwjSYICQ+TEmg2u8+oNBAwQw+HiAP7Sb0fAf7ZFqqi6tnlws0AW9R4wxfUk4vtrEzQwuBCZWpKHPXk1h2zK3Ep2C4kKinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiAfqdxrUuMPki6oQw142cO2GRmXvP58QDdy86w+Rk4=;
 b=QbzSAoDiY4o/jDF7dc7R2F45xK6PqJPEHaGGXgV+/kDgAKIVE9OH4v4D8lCDp7Lp+Zrp4FFiTBkm+K2sQWBDC7ItLUxVqgAdnsVCutt/oEd9dVygXdXs+hl6/CmwBBKv72s2tFpqQU/QkFheaS4sGUwPEQxUgoViErdzitTON3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=victronenergy.com;
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com (2603:10a6:10:30e::14)
 by DB9PR07MB7226.eurprd07.prod.outlook.com (2603:10a6:10:21f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.11; Sat, 2 Jul
 2022 14:50:01 +0000
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::254a:8d7b:3cb5:7306]) by DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::254a:8d7b:3cb5:7306%7]) with mapi id 15.20.5417.011; Sat, 2 Jul 2022
 14:50:01 +0000
Message-ID: <87b5a1e2-3587-ed41-b15b-0158493e0633@victronenergy.com>
Date:   Sat, 2 Jul 2022 16:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 00/12] can: slcan: extend supported features
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org
References: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
 <cc2e57b8-5b29-11b8-aa7f-fea7ac96d68a@victronenergy.com>
 <20220702090434.3fvi4sbf4p4336ta@pengutronix.de>
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
In-Reply-To: <20220702090434.3fvi4sbf4p4336ta@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0006.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::8) To DB9PR07MB8679.eurprd07.prod.outlook.com
 (2603:10a6:10:30e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3d7b447-682e-4f6d-7568-08da5c3a246e
X-MS-TrafficTypeDiagnostic: DB9PR07MB7226:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G94MV9YEDRor4Pbn1eLkGuBph/37COzdyDRkEfwgdTLomelUkt6SAqxb3WcKcV2LNYwgJGmJCF+3Oz7R2HtTQCxqxHHoccDTRnXXNQsOVymIW1RPH2xhMUvSKKRsXAiy7YbMJHoA4H+SCQWDpw4O87ObCXcjupdrCO76qySG9Qh1gaqFTlfGLktLPWlZxw/ciyYPQ5DmVT6G6OkQLVgxahlViP2W3iF1GeFBKOcDD10MEHEeSu7MGFha2+kMSR5LBRjjxet/aLjRYpK1DIVQprb1ZbhhGWAzUbnlHBjlMKvxh1a/E9+rfcWnYkzkwR2nz9lpQiFftlzbjBmozDrU5k1v9x8NUw3X1w0DTp+y0AEvI4+U4PF4BvzU6OgKn45nPiJxho51cwvLiYRhmqS/ZkS1fVi3sHLdNqwCZlX/T6uIYkz+JvMzIGiUfqnftaDfx2sHiQUYc7bDsTG/ambxTiuJ20DlfNSOTBp3s1XAPOJVoC5Cje139pnUVj3HdQDOTIY/PnUG5VFpswuvp4XPiA9W4pzfdP/LIaoqEO2UDe1bQ46CliEUfxVFCbGbtqTEysXgVG4lVnQoDCTwuwotojUpGNFKXsEDSIjMZjzZJhpQuhJ+KNg7tqFPJzM+kIOWZ4KF7Dlyg3G5uLtL5d6NkGYR2bFKphASzaNJd9oA1cowvkMO5ok38sphWNwsvQVd8xXG9O8O1IP2OUPNoaUYR+Z5S5NA2sSlDxhRPkCfAubxQXO6wWa43yQMNLJwFP5GOHsm269nJqaG5PawTnpYqOFZ4uNjvgF5+4RjNYHL1qr2CIGtv4BaZ9XJU2WeLE3CAshv0TW59ccyv9TCj7gER/7g0p8VJCvMdEl0hWBRMO1vwuvoKusXUWtYwMw+GIqD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR07MB8679.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39850400004)(366004)(136003)(396003)(54906003)(6916009)(316002)(6486002)(2906002)(31696002)(86362001)(186003)(2616005)(478600001)(6506007)(53546011)(83380400001)(38100700002)(41300700001)(6512007)(5660300002)(36756003)(8936002)(4326008)(66556008)(66946007)(7416002)(8676002)(66476007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3JvVHFmdWdsNmRqWU91RUE0bkIrN2VKMGRqbmZrRU55ZUJoZEI5WkMwcnV6?=
 =?utf-8?B?Y2NXMk9xcmh0VWZCRlhaWTBZN25Gc2xoNTZ3dTB6TXJBU0NpRHVyTU84c1dv?=
 =?utf-8?B?YWlIbjlveWJFYVovU1R1a2h4UEg3c0Zpcy9hRXU0SVd6dXZCUnZrYStwc3pk?=
 =?utf-8?B?eGkzczlkRENkdmFJYTVPWlVnaG8zRWQyOHJLR3dkRXpIUWpvQ3hRRjhDRVp3?=
 =?utf-8?B?TXZ0R1ZWWGFBeWRFVWxqdkU4SVJUOUpob2NteHRUNFNhTzFvTDVPTkMvL2RG?=
 =?utf-8?B?M0JSajFPcnczQzB0aWRzZ3B1bndZZkZ1dDA4WXJURWE3ci9MQ2srd1RDS2lV?=
 =?utf-8?B?aHl2TldRRHNvb3hIbHFjWTA0a2ZWb1JTOWNhNmpXZmtpcTZPTklkby9GVTBE?=
 =?utf-8?B?MXpPNXZsS3ZsRXRRRjBONmtFcmg1Y3prOUwwejZvRGxmOGdzcUxrVEVIVXI4?=
 =?utf-8?B?RzF6dW9HamxDUGtlMElzYWlieDlKOTVGdXo2NDVMV2c3TmRDTDJTekdBVjU0?=
 =?utf-8?B?SVNUWm90cnc2bjU5NlpyZnpEM1QyMm02SVVHR3ZKZitTY3NQNkk0NGxBY3VI?=
 =?utf-8?B?UjEwMnZNdUhEQ096dmx1L2pSa200OXNYR3NINVMrWm1hU05BWFFiMmUrMDEy?=
 =?utf-8?B?aUZLcHhYOWVIYXB2Nlg5M2pRVzJyZ2RGNGVkZCtqWHNPdDdBaW9USjkzSERv?=
 =?utf-8?B?OXhZdExKcHBGVWdXaUlieVVVL09sYjBndllpZm5rOUR3eFB6b3l5b3dGeU9C?=
 =?utf-8?B?UUdMUkJJYlgybDFNbHN0VmJZQzd4T1dVQkhnRE9PcWlSeWRQTDhLN050OHE5?=
 =?utf-8?B?RHIzUE9vZ05HcW9zN1o4MkNNUk5zazdaUnZwU3JLbno5Qm9mayt1Nm5kSWUy?=
 =?utf-8?B?SWdxK3hyZzFZNDFIaURTOG1GS3FKb0tHZTluOGU5ZjF5SzZNRVFjeWRYcEdV?=
 =?utf-8?B?V0M5dFVZbVh2c0plWUtDUk1pZFVaMzhYSnpMYWRlSW1nZE9rUzFaUHpwSXVi?=
 =?utf-8?B?RHJrMCszV3VHdXJiTWFxMG9wbjA2VlYxcUkwWGJmUGYzZXRpd1dXTHBSdHBr?=
 =?utf-8?B?V0xPcWhaK2lrWS85ckVqTU5pcTFhTWpOa29PZTR1bDlNeDRsU1ZFL1JVMXBS?=
 =?utf-8?B?ZFRweFFXc3pia2lvNHBjWlpEc2V1U3VlUmZ1NzNtY2Z3RHY0NC93WjBwdkRz?=
 =?utf-8?B?eFFiVFhOdVBMTDRwS0QyNGlSMWxMTTE3VkE1S2syUW9McjFFVFIzMVRQK2xJ?=
 =?utf-8?B?VjZ6VnRmVjQ2ZVErQy9mVEQzRHdYNmFhUmlIMWlHeGJmdGxQZnZ4ZjM2ZThQ?=
 =?utf-8?B?Q1BpS2JvQzhnK3BvQjZDb2pNTzdKSEdHU1M2cVBsOVQycE9kQTVlcEQ4YlZw?=
 =?utf-8?B?ZVFDd0p2b0hiRGZBRGlGL1FUT2l3NmdTQThQWWIxeDBvcjhGQjVTT2NFSERv?=
 =?utf-8?B?TWlqelYzV2Nmb3pCc3c3bWZEdkFDUVpPai9EbVFvUDhGQ08wbUhvbEpadTRo?=
 =?utf-8?B?VkY4Ly90TnBPMjR5TmJxRHl0MDg3endZNSsveTB3UFh2bGx4TXFXNTNob2dy?=
 =?utf-8?B?ZEVXTThqSm5CVWVHMnd1a1VKOU56NDlPenRJS3NYQStRRDJITVZNRlJpeXNW?=
 =?utf-8?B?cVpmdldJSWRNdHdNc2ROTE90aVY5bEJYOWh4cmp0czB5Z1lLdWQydHB6ZEV0?=
 =?utf-8?B?ZC94UkhSTlkvVHNQUWhJbEpSWVBYZVF2NXU3UmJ0WElqVXMzS0s5VlVSdDAw?=
 =?utf-8?B?WFA2YnM1RWpKL3gwM3RxR0xZWXFRWndma3h0YVlKUkh5TnUveCtsNXN4K1Rx?=
 =?utf-8?B?dFRZOTNnMmJTK2hBcWN3SG1uNnNTR3JkNFpsQzQrWFFYTHFGZG5pZVIzTEhY?=
 =?utf-8?B?RWp6dU00YUxINWpNcXdFR0NVY1JObW84cFpsUTdJSjVZVS9qRFRCU09HRkJx?=
 =?utf-8?B?U0o3M3ZCV2RTNCtaQ1N1Kzh4N1lmdGpQTm8xLzR6a204ZGJwZGIvUzhxcml3?=
 =?utf-8?B?bEQvYkVyd2FHNTNQTUxyVVdBZ092YkdLdXNxenJhaUpBMGliMm9sUDQ3T0Rt?=
 =?utf-8?B?ejQ5ZlZOc1YyMDJVS2U5MlVtUUQ0bEJ3REJaRkZHd1FhR1Q3UnJBMlBPT0dl?=
 =?utf-8?B?ZG9KV2g5eFI1VVNOMmhVVGlJMlVXN2loODVPY3I4UWJsV21RSzFMZUtXenA0?=
 =?utf-8?B?QzJzallUNytRdGFCWWc1bk5ib0RXS0c1MHhLMDRiY1drVHNUZlltNmtNdjgx?=
 =?utf-8?B?TzMrQUltUDZaL3kvVGpudXhtY3RnPT0=?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d7b447-682e-4f6d-7568-08da5c3a246e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR07MB8679.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2022 14:50:01.7767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAcSMdM8+84Yf/2kvJPW406M8Kd1FqSsqAF+2J4uU4pZFXnofnfWZ2RUtBW7j6RiXVKwfcz6HP1/NQV2XLxSE0ZT8zoaC5uNQbTFCN3sqw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Marc,

On 7/2/22 11:04, Marc Kleine-Budde wrote:
> On 01.07.2022 18:36:45, Jeroen Hofstee wrote:
>> Hello Dario,
>>
>> On 6/28/22 18:31, Dario Binacchi wrote:
>>> This series originated as a result of CAN communication tests for an
>>> application using the USBtin adapter (https://www.fischl.de/usbtin/).
>>> The tests showed some errors but for the driver everything was ok.
>>> Also, being the first time I used the slcan driver, I was amazed that
>>> it was not possible to configure the bitrate via the ip tool.
>>> For these two reasons, I started looking at the driver code and realized
>>> that it didn't use the CAN network device driver interface.
>>>
>>> Starting from these assumptions, I tried to:
>>> - Use the CAN network device driver interface.
>>> - Set the bitrate via the ip tool.
>>> - Send the open/close command to the adapter from the driver.
>>> - Add ethtool support to reset the adapter errors.
>>> - Extend the protocol to forward the adapter CAN communication
>>>     errors and the CAN state changes to the netdev upper layers.
>>>
>>> Except for the protocol extension patches (i. e. forward the adapter CAN
>>> communication errors and the CAN state changes to the netdev upper
>>> layers), the whole series has been tested under QEMU with Linux 4.19.208
>>> using the USBtin adapter.
>>> Testing the extension protocol patches requires updating the adapter
>>> firmware. Before modifying the firmware I think it makes sense to know if
>>> these extensions can be considered useful.
>>>
>>> Before applying the series I used these commands:
>>>
>>> slcan_attach -f -s6 -o /dev/ttyACM0
>>> slcand ttyACM0 can0
>>> ip link set can0 up
>>>
>>> After applying the series I am using these commands:
>>>
>>> slcan_attach /dev/ttyACM0
>>> slcand ttyACM0 can0
>>> ip link set dev can0 down
>>> ip link set can0 type can bitrate 500000
>>> ethtool --set-priv-flags can0 err-rst-on-open on
>>> ip link set dev can0 up
>>>
>>> Now there is a clearer separation between serial line and CAN,
>>> but above all, it is possible to use the ip and ethtool commands
>>> as it happens for any CAN device driver. The changes are backward
>>> compatible, you can continue to use the slcand and slcan_attach
>>> command options.
>> Many thanks,
>>
>> For what it is worth, up to "Send the open/close command to the adapter
>> from the driver.", I cherry-picked this back to 5.10. That seems to work.
> Thanks for testing. Can I add your Tested-by: for these patches?


Sure, that is up to and including 8/12:
Tested-by: Jeroen Hofstee <jhofstee@victronenergy.com>

With kind regards,

Jeroen


