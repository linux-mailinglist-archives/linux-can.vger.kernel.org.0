Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F94551102
	for <lists+linux-can@lfdr.de>; Mon, 20 Jun 2022 09:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239092AbiFTHJS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 20 Jun 2022 03:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239086AbiFTHJR (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Jun 2022 03:09:17 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00120.outbound.protection.outlook.com [40.107.0.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754B8DEAC
        for <linux-can@vger.kernel.org>; Mon, 20 Jun 2022 00:09:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnnUA7NDvJc0W3tm9bLrsHOty/kiJ2SImD737ePKGwXgTZ8ymZO6W3WZ9igM+OCsoGJ1w5co0aSMBol7x8uoo9RBa+kJ09bHDXCSyPnh1vjOTadGetILUDTCPsUvrlHJ/sLjtY14RcIQQzakiwm06gnNal1/vgfy5VEqx1w8kn8NO1lmIdtkWCf7KAS5v8xGLP9oVfEXTAXZeGeXCwaeVv0tts3uHm9DVdrcrRcHrgtvvSOclGTT/174Znv2u7TfG3A9I/xUkR6hQh3bATaiFbEiO6PmB0j2JDMX9uPK7tH2GV4bTECdx0jEn5yHthllEiuR14ffjZxzrVDamB6PgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbrUFdw2Rq9vhSgN4VLQiU/bNRA72xcxTyeeY5TQEkw=;
 b=hpEqOzUZYREMlU0JniFkEyQ+rPQad7m0h+/FQdtGw7RyGX8Il4aRA4nI6uGqtDzWYsMC9hjmmKMSXHp0dfFJKlIA5zctLWFMVo5mUebFoHJqYPG+TyyVdujaUtYDqECmNpTow7WLibin8DroKmcYB4I8/Mx5bYXuBukHMeUZOXmsZ+ZRboVx0wb8Zhfvf6AKFf/sccpleMNeke7yIfEmMq3zSlqqj4w5XAyJV0cpE81+y0swIttmlDrZBMkPIjiylbwbsw+iGrLDgGhBCjb8dYI5H8cZjuKFem/4uZgvdiS7rwJAZJHH+IB++0C8TsYs2oZCan1Q/CxxDvjyNbHSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbrUFdw2Rq9vhSgN4VLQiU/bNRA72xcxTyeeY5TQEkw=;
 b=aSevjJ53Io9EM6AuJi+7b1p3YFWu3uv/3XArTcmeNLihOHXl2f4v+dLh18shZNJZafpSm7ggI9zlKYINQXiRiigkpASHq56MT+NzErqmjbwGhesrFayJVjcFubtM0aUpwFkRb+3uldV2g5SdxZ5Z1cj2mniwdDlujZ7H4x/Ml6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AS8PR10MB4423.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:2ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Mon, 20 Jun
 2022 07:09:13 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2827:221:b57a:e8c8%5]) with mapi id 15.20.5353.016; Mon, 20 Jun 2022
 07:09:13 +0000
Message-ID: <6e01d1e0-4e26-c42f-5d8d-f5aabe0d9d31@prevas.dk>
Date:   Mon, 20 Jun 2022 09:09:09 +0200
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
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20220617141751.ua3emcdaarrnx7si@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::32) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de83ef36-2c91-4fd5-ac3d-08da528bc779
X-MS-TrafficTypeDiagnostic: AS8PR10MB4423:EE_
X-Microsoft-Antispam-PRVS: <AS8PR10MB44233C483556AFBE2F5C2F5A93B09@AS8PR10MB4423.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jD35nPadXNEjfZKfi6CzlBR3ZPt9IxOS68D8s32yHVN3fuusQoM8ojUui/vuFbfZV/FoIJ5pV68uI7SqW1h+JPPSzViGU2Ctg1t8xdm+p0BGPxh9mt52p9wB8Eybl7kE6EzLmWbNzGqM7B5jzKuN7/F4Lk3yUcUzWrPZaAfDFDAiCrs4T8LB0MKPE1Qushs4lxg9a0OUIOP/6t5n0yuh+BJIJLeAKwS+LdlXDq2vDxQPlXxkOaFgprxauoPXGgvalMKQqguYAsxk2f6AOZeL98qhPANp1YSfVaIYEsbA1wGce7NJaCdnIUPZAEI/YeeOuLiTxeFIkr5snoFaPLZfSHH8BOTImBjdX2KD+PTcIbeS1yEY9GigO2rY4AA/1tScYzJfE1tvV2RhEyejWAljdQZ/FD21wjEhxVVAc/mYEkoQFLfkksodNpFu9R0YrJ9MWzlbaNVV3XM0jPNraDPdBU/vuq7Jt+SWbEN32tV0vClPmTuhyqVXsyzHRZ08fdfMFjwuxQE/g1V7dJVYpeJpxScNQGVYwmCz7ECEuvkTBLjm4U/NYd45V+6l8V79eH7E2UC/BszeqHx5PJoFrvFVi7zOyAyO8emNxxBWN7PLu/UU3X425GqWg6U44+CaOKiVINrPolD9s3nmI2jSe99SfzMI0Vk5WzCxQhQgi0zM74Fr+esebGpUqjHVAldzC6fqX+DP59X9erVkNe0WwAFRBxNdQOPqlsfWe6svCfVb5Xf7525r+CfzwmaYl0Q2qfSAGIUPVQtoUwU8Zu1BuiIkWOy+dE98XqxHP4uw8Lib7AhLmeTxNBsqAsIf38TlHUGoMZhFk1C9TgALGsjHg4v4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(366004)(83380400001)(2616005)(38100700002)(38350700002)(186003)(44832011)(2906002)(8936002)(8976002)(36756003)(31686004)(5660300002)(316002)(53546011)(66556008)(66946007)(6916009)(6506007)(6666004)(66476007)(4326008)(8676002)(6512007)(52116002)(26005)(498600001)(966005)(6486002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3czeHIzSlFxbU1TTXdoWms2OWJqL1RUMVZtdmVVd0pPZ0kvNkt3V0hqdWh0?=
 =?utf-8?B?bUpIK2hDSEkvKy9zbS8rTmsxWDV0SDYxUDNQU0VIbnJxOVpGOS9WWm1xVTZa?=
 =?utf-8?B?QVJveEJ0ZkVLM0ZUSXQ5cGxPRTFienYvUGgrTEhWRW1LMUpsUFc4UGlzUlE3?=
 =?utf-8?B?Qmw1MHdVOFRMUytwVVdLbTlwVDgvbzIwVTRaaDAwTlY4T1RrVzdzSU5UWHh2?=
 =?utf-8?B?cGN2c3VHaGxwWnRLUXRjVWx3SFdUUDJHRUtoc0JwNUIxYkQyblVCNE9NM1hp?=
 =?utf-8?B?WjlscGp5cm1hOVMxVUZMRm1YeTBpZVJqdnRPTTA4RGxQa2xuaCtnZnhMZzJw?=
 =?utf-8?B?ZGdQQllZakFyRWZYVGFyV1BQM0xZMmc0cWIwN0Z3NVNtUlVMZ3JaNnJWRlR2?=
 =?utf-8?B?N0g4d0xkNFlxcDdYdVRzdk1vRUxwZC94d2cvZzFvSGF4TWVUY3VqSUd2cEY3?=
 =?utf-8?B?b0grL2w5SlQ3WEZrSi9SQit2YlVacEFQaS9rczZYbUJJVyt1a0RkeFgxYTJu?=
 =?utf-8?B?STBSQ3ZhVldIYVp0TGJYTmJmYzgxRlVpeUJzZHllZHRWZGhLYlVnTmR4KzJy?=
 =?utf-8?B?Q1VqVWdzN1ZiSEc2blZPTW5zOHFWa1hCU1VoOUkvck1xRlgzRUpocmowZlBz?=
 =?utf-8?B?czZPWk9DdFlsZzVBdDRyQXBYMjBuNGwrdFNOQWVGUUEvUVRwVjBUWlUyTmE0?=
 =?utf-8?B?YkNDOEZhZDdaL0N3dHRCU3ZnMkE2RGNMSDlyV0tJQWtZdjFkWW5uejgwZzRP?=
 =?utf-8?B?N2hSZENTYmh4SzVGVmtNekNYb1h0ZUlkUkh0bk8zS2UzUEY0aGVZeERoOHdF?=
 =?utf-8?B?WmdrWUJXY1JOVEUvcmJLNW53OEFoZ0ZTR2NmdGd1UjBqSjkzQklQRG9RL1lu?=
 =?utf-8?B?MFRUd3VwRmJKQnQ4Vzl0d1RNRmVDc2M0R3JkSmhBQTVoQ216bm9aUzVNejZa?=
 =?utf-8?B?UGNmck42VHprWHlFMGIwK0k0eUxUV2s4a1pHdFNmajQ5UER3UDJqMDVjT0Ir?=
 =?utf-8?B?NUE1Ty9IVzMwT0Q2VktvOVF5ZTdVOFRzSWVOYWZQMkNMditXWXYrMC9MVjFW?=
 =?utf-8?B?aU84bW1SeW0wTllnd0thYkE3QXo1c2REOVRUYnFLY3E4Sk8vVEhQY3Z4eXhR?=
 =?utf-8?B?ajZzTGx5dllkSXp2QmZYbnBJOEJSc21YRmh2djNKUVdQMzJGeFhpRXJLZHBO?=
 =?utf-8?B?RkRUTldHZXBYcGFLTmxvV3lPd1lINDVHNEsvOFRrc2lnLzYwUDJwbXpmVmJP?=
 =?utf-8?B?SWt2enFDYnE5NDA0cFREUkQ1K2xOb0dacWxXTmpsRWFIaWJLSzc5M0c0SWxM?=
 =?utf-8?B?em95SXg3UjlvR2JCYjZXUUNNeVhIVTF2S3g0ak0wYXgySk42RGVOOXZJdXRj?=
 =?utf-8?B?Vyswa1pHOTZ2QW91aXlKbEhzWm1LdFV3dlByM2p1TWFESjNDWGNlWGdIY1cx?=
 =?utf-8?B?ZUM4ejVwWEx0eTFNTm1RQ1ZUQTkwc2dMNTV6K1JUblVkZ1pMY0oxV2hHaE1G?=
 =?utf-8?B?SklLdWsxaDFja1h6NGFXR0lwT2VIdUliWEgwVnZ5T0ZqcEZ3Y1J1QTFEZ2RQ?=
 =?utf-8?B?R1k4bUt6WFBtRWZwK3cwcWFXbFZHaXhHaC9YaEZYU2NEOGdnTFdOcEZSY1JP?=
 =?utf-8?B?YmN0Tkh0M0xId0svdSs3TFA5OUhvQUNpckd2K2ZUY0o5OHAwRzFGRG1ZaC9k?=
 =?utf-8?B?bFMxb0d3U3RnbGpMM0xZZGN2eFBoQWEwUnhmYXRiZ3dEa2VCa0poRGdGWE0z?=
 =?utf-8?B?bm9MT040dFc0L3Y4ZE5qOG1XY01yeTZrQkVCREdPWmREMitOK3RlZmhUdjY1?=
 =?utf-8?B?RFo2TUVpMGw1TTV5eTNPSjdEL2wwQzFKR1V3Y3J6ZUg1bVVLR09VcWEvc0I5?=
 =?utf-8?B?UExOS0sxWDZyNmEzSWVUY24zbGgxMlR6YlAvV04rYjhQMDZvZDZCaDRybWlo?=
 =?utf-8?B?eFF6cHNpRDJTVVBNUkVsT241elV2Z1Rxbjg3cUk1Z3VKd04vZktILzFzbjZE?=
 =?utf-8?B?d1psWWs3b3ZlVEJSRDJ2b2luMmcxTWRjZDhFeEVNeXFkSUFkVDE3TUFIUExR?=
 =?utf-8?B?V3Mrb3RrS3UrdG9JMHVzSVU2TkxkVTBBUVBLSWc0U2wvRkZTa3ZrcDJqMUZK?=
 =?utf-8?B?VEEwMGpxNlZtaWRjWUNTSld3YlUxM1MzUitvMDBMUWVhRktKdHE2VHJZTU01?=
 =?utf-8?B?d0Qzd0laNkVjaEJ3Mm82dEVSa0cxTWE2QTdmTVJoQ0R4L3NWNTVKTkdGUklp?=
 =?utf-8?B?RnNneGlDd0lyQnpJdWY5ZmxiVGhERlV5WUdXY0x0SlExcVNhQi8zSEltZzJh?=
 =?utf-8?B?bXozbU9zUDIrWDVJcXF3V0xLVm9lTEdxQjlhSm5iWTdlNGpIQndianFZVDBp?=
 =?utf-8?Q?32mXbEhsas6vM+Mc=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: de83ef36-2c91-4fd5-ac3d-08da528bc779
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2022 07:09:13.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/J+fJaOWoM5c3xfC24oypt30bFGgtf5k0G+6zgJCYQndT/qEkMsccb8V5WSOQ0g8s9vmEpgt0/cv1H0RTp5ZaApYLJjOlpRU3sFW2YRNKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4423
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 17/06/2022 16.17, Marc Kleine-Budde wrote:
> On 17.06.2022 16:01:56, Rasmus Villemoes wrote:

>> There is still something to be looked at, since I see
>>
>> NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!
> 
> Update to a newer kernel. In v5.15 this problem is fixed.

Oh, great, thanks. I'll try to give 5.15 a quick spin, we're mostly on
5.10 because this project started when that was the latest LTS.

>> when I start the traffic test. And the dev_id reading still doesn't
>> work (though it's not really used for anything other than an
>> informative printk).
> 
> What does it read on your board? But still that transfer should work.

Depending on whether the miso pin has been configured with a weak
internal pull-up or pull-down, it reads either 0xff or 0x00 - and that's
also the case when I expand the read to all six e00 through e14
registers. So the chip isn't really driving miso, and I think that's
because CS is released between the two elements of the xfer array.

>> But I'll have to get our hardware guys to help me do some soldering to
>> capture all four channels at once to see just exactly what is going on
>> there.
> 
> Have a look at these: https://sensepeek.com/pcbite_20

Yup, they're excellent :) My desk: https://ibb.co/LRdtt7Q . However I
can't really manage to get more than two probes directly on the mcp2518fd.

Thanks,
Rasmus
