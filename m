Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D987554F8D1
	for <lists+linux-can@lfdr.de>; Fri, 17 Jun 2022 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382150AbiFQOCF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Jun 2022 10:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382019AbiFQOCF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jun 2022 10:02:05 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70112.outbound.protection.outlook.com [40.107.7.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C64749CB8
        for <linux-can@vger.kernel.org>; Fri, 17 Jun 2022 07:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lktOpI+vZLimBOF5s4LkZgYzG+MkMOsbU3hRt9cx1AuklqMgV1nZAkFTt64taOgJvDBK4MTr7twUod7wNUkssjU7l+EddRfHSAnOWvU7a5UHmQ6aZlR8j+8DZvxT0MlYpeQMlp1i/Y3akPUAr8VpGTMNhX/HDKBd8YhRhEbhTRTePdN8t/qZrYoMXmmbao+B4M9ovzOwVezgK0MrH+oL2DIYrcRaduO3JyA+I/0z5cIe0VwybinRArGWGnSTD98TXf2++CFm/uFxZveq97ippbALemY802B8UEGHVKawKmnHQS3TDP4HDa/Qo/pLKO1YncC/VquItEkZf8GNdPy+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYIKsE2C0z0xCcaatWILCiH1997kiH6doP8mc5u3Ag0=;
 b=fDzB94ji622mqNAtiEbuWHgDvC073QOQRbKnn4/4StTxcnBpgH+lxCU9iBThDy/aR+uvOayfV9XymltPLfRfRLAxG0kq03CNk4H1qdjfut8G4Uq2b4wAODH6t3fOWQ9r5gN7D5ODNtsoaK+vCfB48Zzs2QCTj65dS4+1bpblsoSdwZ+OIcocs2w0KXUMyDVQdx2qmKQcqEfAVM0N3HWB5NzNyEC5NBjXoWOUbxPcVlBVigacTBexM+b/qn0ljtKaKQewjqTk7GqHGjzD6qI052JXuyMT2aU8gK4+WabFlgWX84ygDc0ymmiPB+YDf7R5Q28bVDZ2hwCMcRTl8kccvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYIKsE2C0z0xCcaatWILCiH1997kiH6doP8mc5u3Ag0=;
 b=aNkKiCLihwPqJb8d3IuR+N06QN9TGzH52yVVG8Kn6sAqBuMKBe2UhDlSuWCey+NWDuMUPlLCFl880fMYYSOhaZHQJzATsW94kDwgJBIVU71+e2iyw/wwtzjvGZ5A8XvmQWkqczKx+jq1LYxV/LFSpQeTLQOsalS7Zub9tgeYQQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by VI1PR10MB2637.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Fri, 17 Jun
 2022 14:01:58 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8%5]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 14:01:58 +0000
Message-ID: <8db56a87-a1c7-1810-ad74-c7a8e268a00d@prevas.dk>
Date:   Fri, 17 Jun 2022 16:01:56 +0200
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
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20220616124056.cnnvlqwwkknjta7w@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR01CA0044.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::21) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 292b038b-7cd1-4468-3fed-08da5069f1b4
X-MS-TrafficTypeDiagnostic: VI1PR10MB2637:EE_
X-Microsoft-Antispam-PRVS: <VI1PR10MB26374EE5B7D8045D9C0AD22393AF9@VI1PR10MB2637.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOybF9DjMbwdvHZTACeoe/GSr1qS714rU+lk9EUX65F9nBWPaiexE4lNVopXG6vo9noj821gwe+9lLXyT6R2flWDu7zsV5iBPfDJpo2do7hv44Pr5wnj1kDB8+kEGLuBQqtAuVd7AIHwZB2yWQeUp32BvVMWTZcWGAFFYw1QAeSr7II+kjTXIraTPMsA78LQLqkEcXTUMFg6myn4MjhgHragpdgNCSCRr1OxBwF8PlnP0mrm9KxVndv0RC9GYudkosERKvZvlvF4ly6SXlrqkIINs1yGrt/Fw9AWm7lsO/reBRwFZZyj4sR1jRjfj+8uXXUZ9SKaNwmI565d8v+eMaX3MonfuJp1SteNbDNgiMwbIzXdLzYMl+bXnubJU1FFR860rN5k/SKN4aTn4HyMBvw+CV32NuiLCI/c11SkwSjB6WU0n2DK52horYPuBr/gmaxav9jtJuzdu1iZtuMWZCE4j7YG6RIlonsae1ioW0wTailAUACy258GE+Y7NT9oIK4mBT2LFmdqI+bqf+VHxpbywKu8i7AR1teY14PLwkAgJrjghLHrPGOzn8C0zwTztwR1s5Fu5E3JWj1uyArzvP8ORqBf76Mfac26ymCeN2LxOT9+KjWmeXQOblpy72cObpG6wouTzuCxHKeCkbHkguaz7On7mgJRSllXNenBp1vxVDxy6fYSm38qerABCBKa1kT3Jj8rpJ5UOwhpuVpXjGcJtK+jxDJ857lTiYhTV1hJlegmiJRJBcGYc3ZCfcOUfNrFUbKjcTNpal7fn16/sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(31686004)(8936002)(5660300002)(44832011)(66556008)(8976002)(6916009)(66946007)(66476007)(4326008)(8676002)(86362001)(6486002)(53546011)(498600001)(52116002)(6506007)(36756003)(26005)(2906002)(6512007)(38350700002)(38100700002)(31696002)(2616005)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkVVNHUwdFhZM2ErUHhrRG9UQ0NxUUluODNyWjBwL0JDMUc5VEJicG0vTTUx?=
 =?utf-8?B?VVh5OEpmNWcwMTkzV0xWeDRkcjBjUzg4RHlCQkFWbWRBTGhPWWx5VjRBVGgv?=
 =?utf-8?B?emI0Sk1uQW5CR1hBN3AyNG1WcjZtMHZRZDNNcHQyemdwSUFLeWVZWmlud21R?=
 =?utf-8?B?cFMzZ1ZuWmlyRys3czZwZUJPb2FrTHR5R25MSTk3VWVycUEyRS9YSzh6S3Br?=
 =?utf-8?B?Q2RUSmdSeE1uOU83VlowZFptSlhLVU5YM3dUdWZlM2V0L1E1Y1ZvQUNySzdz?=
 =?utf-8?B?d2ZtdXlWb0hOQkpvbnpKUW01ek5oaFdTWHh4dGJLdHFRQ0JFNHhsSzUwSUd1?=
 =?utf-8?B?UWt6YVRzbi8wbUt4VWZtc1k0T1VSWDBtU3JLYzFXdjYwMGFZNnJJZE5kL0tr?=
 =?utf-8?B?cFlKWXM5N1NuQklIb0hZNDhmS3JodEhXYVRDUGgyQ0pBN1dwZm5MTVpvYXZK?=
 =?utf-8?B?SHlrRjZ1MmhmZnRHQ2FpSFk3MnlndWZQTnAvRm9FUlB1ZDMxM0JNeVk5YzJT?=
 =?utf-8?B?cmZ0RWZLdzk5UFl1WStUVWR6emI0MzFxUjJDZUtxU0tyb0hacUUrTG9kV01r?=
 =?utf-8?B?TDFKUFM2cTlhaEZGZWV5SFFDL0tTakU1Y2V1bFpDUzBQV21DQWhKbHI2cnQx?=
 =?utf-8?B?S0Y1alFBS2N0aDFqcXFqZkJsQiszc3U5RWdJSUpnN1RvMnJ0R3RuSDJYbG0r?=
 =?utf-8?B?UG5EN0x4aDdxYUd4L1oyTVRESjNaMGltelpZNGdHTG9YczhWL0lpTHJ0QkRz?=
 =?utf-8?B?WmltM1pYbkErQXQ5dFUydno3WHc0Q3RvM1lHdjZabHJ5V01VdS9hUmtHTnB4?=
 =?utf-8?B?emZqdlFoeHlGdTkvdnh2R1FKdk9tODN6RVJmSnVwRHR3cTY2UytNQnhsQzlq?=
 =?utf-8?B?YVZWdDFIYm5HdWtIdUlCZUhQUndDdEVnZy8vMVJYYWRZSnNiNE04eXlzVGRI?=
 =?utf-8?B?Q0dOMGp3SEIyckUrOG9KM2FDakZsR2RIRGhZRDBsYlpkTHJVK1ZPMEVyZE1V?=
 =?utf-8?B?RGFoaWhlenJGZmQ1Q2dRZzdhdXk4dERkSytXT1daSmFtdnRHcjNQWnY3dTNW?=
 =?utf-8?B?NXM1bS93Vi9ON2s2cnkvaFZ4QVVpVzg4NlB5ZkJDbE5iVXFpZEx1T0JMejZZ?=
 =?utf-8?B?aEQ1U3lZQ3JRbExlRHRIa0JkN09DRzNOdmxVK1puZHgrdFM2UlJFZnFydjgw?=
 =?utf-8?B?Wk9vaDJZdnZrdXdteUtsQ004MXF2ZmFlWmtnTjBQUklUNmJDUUFkOEc1bVJi?=
 =?utf-8?B?R2w2QnVwTHJCTnVSZmlHNUpLZUViSFVCcTVzRExXZEF4UVQ3SWlBTGs5UzM1?=
 =?utf-8?B?ZXVuZzhteUxIU0RUKzBLbkp1OTJxTndoN1Y5TlNqWnAxSHFQVG5xbUNCOVlI?=
 =?utf-8?B?cENLTFVES3BWOHAwdmdpMng3VXRxMjFUMERYL1NTQThRdU1EME1pdUNDUngz?=
 =?utf-8?B?SEJ3OTREZGd5REVCYlNKV2RVWjJvM3RBKzBjeWRGQUpROUF2RWhsV2g1NlJ6?=
 =?utf-8?B?VXZJY3Z0djZoTVlUZENpOEZ5YmdBYTdFbUxMM2Zkem1ISzA4VVpKN0N1VkJ6?=
 =?utf-8?B?VUUzTjIwVDZjclZ6bTVFSjZwOWlQczdxQWRobHZFdVlZQThJdXdvK2FYd1F0?=
 =?utf-8?B?VmxWWkJsTmEzV3lVbzZ3MUEyTThUUmtsa0h1UjhLMXcxb0IvT3Z2cmtkekNa?=
 =?utf-8?B?RnNIazFqSnVVdUxiMXlENmRsRmJLZ3J4T3VKVUVVQXJreWt6OXFQT3o3Wlg3?=
 =?utf-8?B?eG1mdW54UUQ4ZUp5NEo2dFY0MGY2QmUydWVOYUR5MEp2bG1zamxGb3pmbElu?=
 =?utf-8?B?NlBkU0x5a29pbmtyUWplNXJlNW5uRHVVTlVnaS9RSXhuRFN6UlJycHUvK1BE?=
 =?utf-8?B?TEk2VFd4TEViNGFTY2RiVVdhWFJndHVKWERqR05uZitKVGwra05kUC82N0d1?=
 =?utf-8?B?M2lyY0RMQTNXSFZuMHptZDBrdHc1dGtlMUlnMWU5S0xSaXdMM2pJR0pZUkRD?=
 =?utf-8?B?WjVTSXVIYTNDVFhTTkdDbExNMUV3TjFzOVVEVVpicFIwR0xzVExyaDRiK2Jn?=
 =?utf-8?B?R3pWVzFyOEVVMHhaV200M1FJRHdJM2xXUGc0Zm4reE51UFRla0dGR2d6Vk9q?=
 =?utf-8?B?Z1paWlNtOGFUSElzK0NtK3RuTmY1c3Q5aHdZTEc2SGpoNUU4dElQNWUyVGJE?=
 =?utf-8?B?Q2s4eGk4TVVPR1ozTjBIQnkzYkNVUEpicWZwaHNCV1lKYmp2MkZ4R1hvSWY4?=
 =?utf-8?B?NHdJdDIwcHhabzFpN2o2RG5Jb21TVUp2ZytTdFd2akl5ZjgyU2hhRElCOXNR?=
 =?utf-8?B?Tmk5bkVuNS9EVmMwS3d3ajUrbzdaazNwb3RNemttNnRTREdSR2pSVzlxUG9E?=
 =?utf-8?Q?C4AoXdGzk6bUalBY=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 292b038b-7cd1-4468-3fed-08da5069f1b4
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 14:01:58.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKiRp9ypAWwDrZAARK2TsqzwaobSqrODRL5/bLgtQIDHerk1Oc5iwofAd92hYLKo5Ye/LRLTsoi+6Rd6QAe75Ey/YOn9nWeSlsw48cqiBhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2637
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 16/06/2022 14.40, Marc Kleine-Budde wrote:
> On 16.06.2022 13:21:52, Rasmus Villemoes wrote:

>>> Have you enabled DMA on SPI?
>>
>> Not explicitly, but nor have I done anything to disable/not enable it,
>> so I'm not really sure what the right answer is. Is that a CONFIG_ knob
>> or module/kernel parameter?
> 
> You can use "/delete-property/ dmas;" and "/delete-property/ dma-names;"
> in your board dts on the &ecspi1 node, the module parameter "use_dma=0",
> or the kernel command line "spi-imx.use_dma=0" to disable DMA.
> 
> The SPI host driver uses PIO for smaller transfers, but switches to DMA
> mode for bigger ones (IIRC > 64 bytes). The clearing of the memory
> definitely falls into the big transfer category. The SPI DMA mode is
> broken on various kernel variants (downstream, mainline), kernel
> versions, SoC variants and used SDMA firmware versions. For the
> mcp251xfd driver DMA is also slower. So switch of DMA and try again.

Thanks! Disabling DMA did the trick, and I can now send traffic back and
forth between the two chips, and since the RAM now gets properly
initialized, I also don't get the ecc error interrupts.

There is still something to be looked at, since I see

NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!

when I start the traffic test. And the dev_id reading still doesn't work
(though it's not really used for anything other than an informative
printk). But I'll have to get our hardware guys to help me do some
soldering to capture all four channels at once to see just exactly what
is going on there.

Rasmus
