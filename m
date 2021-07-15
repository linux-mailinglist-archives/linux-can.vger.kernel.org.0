Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2DD3CA1CD
	for <lists+linux-can@lfdr.de>; Thu, 15 Jul 2021 18:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239659AbhGOQHQ (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 15 Jul 2021 12:07:16 -0400
Received: from mail-eopbgr00100.outbound.protection.outlook.com ([40.107.0.100]:1791
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232659AbhGOQHP (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 15 Jul 2021 12:07:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kh7PNGZDM+7bUToGE3VRwbNHRBt4lnIFG9rSGLByvzv0vAQv4a2nvNT534ldKJmVRzZd75bHtwTPUOC4cYodeQ0bugFR2HJwbRS2GJ+fObZ1MJg3JqyOYGFQvZ4PQTJWuW7E1bwGzMEZDALxyVr0j/ILjn02uQqBJbuJ4qrNWF4ZlMMBg9zuuriwOqxVQ3kxL41geOfffgJh1PCap7pL0k9d5jkcXEMBMSM1wdMspUpDE3opqgHjv+lYxITjbtL6ZIQTHgty7zc6CkolO+m/q5wWXiCDs6W3COtai6z/4c8OFdzphEcTWzGHDCuoNexqdQyaY4tnpDs9/5N0TkjzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owMMgPhp3NfXlbKK7jZEE1f87i/dcKrr977vHZ+Ri9E=;
 b=hBIYR0h/14BvNr06Ld0RGRpNRRKJ4YqtMbSf6r0v/wErDMkfw2IQbyJHItCZM295xJgIsvnIe7UZeCMr1gy4p7du5xDwaPEWP+7sdSf5zM4Qeu1EQYUzEvQ5jbjQVZ2GnDtuhI625NURiUGibq7SQR1hf/tZOTuugYAD5dKTzW09egRBH+fJNUK8lgzBPgJlUE8pMJwmiHF22/l7blg2F5j0yHvTdIrJ/RG+zHpiku9RLXlSj0jSXpiZ9plP5iZwykrEPtmek0+F0VmZ1n1Q0lzcTAI/zIcj4a0htA97sfIBpVYaFfbVirJ8dBA2KxrIgHDKqBVOLINqOAZo92vrGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owMMgPhp3NfXlbKK7jZEE1f87i/dcKrr977vHZ+Ri9E=;
 b=ND5giEjUjJD8HR+8N+8Qlegq40k3Igt8jTvxMlgFnBmoLtVrR//OCgkxNtiFbSctyaCqga9xIDZ+/WOHIuu953SHd7KPDW6Cvab4XykW3ROS748oGAmIFnhzT/qkfSj3UC8cg9bwMSIrvaq3wDfVKmqE3tTHSm9XC0lXbg2ymUE=
Authentication-Results: lists.oasis-open.org; dkim=none (message not signed)
 header.d=none;lists.oasis-open.org; dmarc=none action=none
 header.from=opensynergy.com;
Subject: Re: [virtio-dev] review of virtio-can (was: Re: MSG_CONFIRM RX
 messages with SocketCAN known as unreliable under heavy load?)
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, virtio-dev@lists.oasis-open.org
References: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
 <20210618091614.nqcvvmtf4wo4aejm@pengutronix.de>
 <8c76c15d-6252-8af5-01d1-71752cd0cb7b@opensynergy.com>
 <20210625091938.5s7g2eiuz52vx7fh@pengutronix.de>
 <20210714031300-mutt-send-email-mst@kernel.org>
From:   Harald Mommer <hmo@opensynergy.com>
Message-ID: <3da52df1-c639-94b7-a3d1-f7c03d422f41@opensynergy.com>
Date:   Thu, 15 Jul 2021 18:04:15 +0200
In-Reply-To: <20210714031300-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::24) To HE1PR04MB3177.eurprd04.prod.outlook.com
 (2603:10a6:7:24::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37fa4c95-3bbe-4451-4229-08d947aa32bb
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2730:
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2730BBC27038E92E3C3443D0E5129@HE1PR0402MB2730.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NBr+seFzkJSt7udixnLVLEfwRiGjNSUVesQLsaJhYiZ3+Z1om6f8qDGI9V/7pdmVUx8GC9Gaa0MaBVtC3flJMlNZCwm5WzkAw0qbxT67eh+4CVJRdeB+xddQ80K1f2BzViHDJcdhvn6LlA1azyuENGBPS+nFJLXqelB6OZlVSSwMglm9IdBsK8YveiqJ8qeP+zXMpDD396B2g0gg9Y206V6nrrg6vD03Y7mBXU8dSoAGrnz0A54Xg1GruQth+jEVg1kbPG8XRS+C/Yqz5XyEDVjliV77sUu8+LAB5/n/oS211p+kuLMZQuOysQ5Geuf11zytSHKX1FKGBYxJyvWVs8rX4w+95rrEi8Had3F1CNDnwRVXsLXLMNQ+U+nBRbfF3lhRmYRgKqMnDGcfJUtWiiwTW8qd3cNwnGjylqqcWc88kV/UjAEbLfbGiH6j0+E/906haqYytLbww67a6SP9sAnQxlhqS/8vxTG3UG/VGPfRNQiAUwU8D9hVCKYxivu/zIgdHFLEuvaM5u2fJl8Tx9VGOXsUAvM6fAWebYzrevaog2s7qFVGt3mHM9V3dDmTDjaBcg/Nkt4BE5sXmLavXOMjM31GRbf74QEPXxco8gaOXuBpK2yRaogS5lSZd7r1HBFX+jKk5Nd/G9JCUSdUUlA/wFPJk35XIp35JMMcRGOFdp5knxFli6dXJpkc6gd7Mk9kmLyLl/5XAgHhayVY+zHvTSF00ZBz5wioBEa9KgM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3177.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(366004)(396003)(39830400003)(83380400001)(186003)(26005)(66476007)(66556008)(66946007)(66574015)(38100700002)(36756003)(2616005)(478600001)(42186006)(110136005)(15974865002)(8676002)(31696002)(8936002)(4326008)(31686004)(5660300002)(2906002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRyNWc3MGo0SnZQSmRTTjhZS2s2UHFPaTh0dG84a0ZmcHJJVS9KcGRjdTVT?=
 =?utf-8?B?NFNWYWYyMzQydERIOTF2bXFYM0dHNmFTajJVL2lyRWxmUTZ2bXc4by8xeTBD?=
 =?utf-8?B?L1psamJTSVlDdlBMSE1sWWEvVU1rK1J0WUNMTThCRlRXWkZ0eW1PUjFGY3Zq?=
 =?utf-8?B?OTl2SjhUNDI0ejM2ZXJWMVpSY0QwTFZvQW1wT21USUV1eVpzVllnRTNwVFlo?=
 =?utf-8?B?SkVVTXRXaS83dkhlZ2NtSlovaGdhL3RZSWJWcXdyTkRWSDAwVEswcmQ2QXFx?=
 =?utf-8?B?ZzkxZmdvNG5uZUhCeWR2K1U1a3N4Q0o3VEJOMkk4NXlLL3c0czNmcjhkdEFJ?=
 =?utf-8?B?eEZkVTM0cnQyTTVkb3lUSXZwS3ZVb1ZjckhMZXFhS2h2SVErdElrMGhEYllx?=
 =?utf-8?B?UktJSFEwRENkd2RUL1c3d0NLamFBUmJyYzk5eE0wRkN5d1c3WU5IWUF6OE9Q?=
 =?utf-8?B?empYdllvMFdXaVgyeWRHYTdMVk11aE9jMXJpWVA5YTFkYTFHNkdhQlo5TnU4?=
 =?utf-8?B?L1hsRy96bXZJdHB5aC9BSDB2Ri9xS1JqcjkxUXYrV0RERVdVWlg1ZEFuMGlK?=
 =?utf-8?B?UlFaKzlYdkdIUXlZeC9YVkhzekRmY2ozR1RJZUpHbzZUTHRNVTZoM050Z2U3?=
 =?utf-8?B?akxqQkV1VngvQzgxQ3ZuYWFWbWJwVW8wQ3g0cVVUQWQ3N0ZucTFhbUErWnVk?=
 =?utf-8?B?Mm1BTld3bFNFYy9jRDlPUit0UzFITFppS01ha0JTbHNOa05QaTZnb1dodm5X?=
 =?utf-8?B?dnZqUEMzTnVhUmM4SEIzZmhueHhvaGJxSEJuT0NOQjlFRUU2OVhMeHVZZFUw?=
 =?utf-8?B?aGxCNHlOYnBJK21WM1M3c09pZzlHOHRrWlpzVzkvRU5wblVyMFR5U0JQcC9D?=
 =?utf-8?B?RndOK1d2b21Gcy9CcjFlaVNDaG1TZENCWGZlZ1V1MVd1WGYydHZlT3lyRTJn?=
 =?utf-8?B?cnFWSkxUNEVRblR3ZHA1akJSZk1ReEgwelEzVXZGbys0ZmRwUlE0cXZHejl6?=
 =?utf-8?B?UldxQmRRQ2thZStwN0haVTNvS0djSmVOVVVrbTBhNkNKRW1lWTBJM2lJbEtE?=
 =?utf-8?B?UHV5dXhIeVVERE1nY3VHeEtoTTgvMU1rdGhLak1VZmVmblRhVkRMMEVVMnBQ?=
 =?utf-8?B?SUk4WlZwOG00d1VncHFVeW9ScE5YalZod1ZadFIya3JKVGNmV1RZU1o5cEJl?=
 =?utf-8?B?Y1g0SU4wZHhkUGlDN3dpZ2FTdDR2dVpHeVlVeUxuS2dLaHJqRGNNaWE3dTRq?=
 =?utf-8?B?eHVMbHBrTWVweWc4Q1BMOUs5emFjNy9pOTZ3b3ZuVDdhaE0rbFJlbWZ4MzBN?=
 =?utf-8?B?MXlFVmwxV29BTHJmZ2V4RTBySU5CRldVd2RsaHFpSllILzBWb3NEdkpualRK?=
 =?utf-8?B?dGFZSlk2MXF3Y08vM1pFbGRDZDhaaFBlV280bUpGa2tmOHlRSWkyQXQ0UVhO?=
 =?utf-8?B?MlBQMEZnRG00N1BUOUc2WVUwV3Z1WFJwTU1VTnNJcHo4NytXaGM4Y21ldU1v?=
 =?utf-8?B?RUM4M2lCclVtYWxZMC8yRytUVE03Q29mQnpNdGF3eGN1bnprelVzdmw1Q3NT?=
 =?utf-8?B?MExpQWU5NWZvVkM4UlZET2QxSkEwcGc2TnhndnQvV3FDazdXL2pKMnFPTVpZ?=
 =?utf-8?B?K2kwUWdpRnZMODljb1NnUnlxZzNqQUdlTExvVVJBWWltWkJYUldWUjNuY01x?=
 =?utf-8?B?elNjWTZVWkFaVS81NFdHQzEwYXM1MVc4ZHlVZEJwL2tneUtPZjltdCtrdkx0?=
 =?utf-8?Q?BNNFlva2Me9i8xHa7A7cqPrKbJfExMY3DY+bdA/?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fa4c95-3bbe-4451-4229-08d947aa32bb
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:04:17.2520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3W36FZGPIHpN6Hh74gaejYtbvpoCCExzJfxYrzo37Pv2shITCRsB+WWemcKYjJe1UAD5+ZuiBx9pRpyTLLb9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2730
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Am 14.07.21 um 09:15 schrieb Michael S. Tsirkin:
>
>> As mentioned before don't make this AUTOSAR specific.
> If the specs are more or less identical it might be worth it to link
> to AUTOSAR too just because it can be downloaded for free.
>
> --
> MST

The specs are not identical. But the specifications do not contradict, 
we are talking about the same CAN. From this point of view inclusion 
would be ok. But there was already a comment about the AUTOSAR 
specifications highliting a problem. While the AUTOSAR spec is 
downloadable for free it is not usable for free for all purposes. This 
may be a problem or even a trap for people.

AUTOSAR CP R20-11 says on page 9 chapter "Disclaimer":

"This work (specification and/or software implementation) and the 
material contained in it, as released by AUTOSAR, is for the purpose of 
information only. ..."

"The material contained in this work is protected by copyright and other 
types of intellectual property rights. The commercial exploitation of 
the material contained in this work requires a license to such 
intellectual property rights.
This work may be utilized or reproduced without any modification, in any 
form or by any means, for informational purposes only. ..."

Cannot judge the exact impact of those sentences, I'm an engineer not a 
lawyer. Not my field of expertise. Free downloadable seems not to mean 
free usable so it may indeed be better to get rid of this reference 
here. Poisoned? Don't know, looks so.

Regards
Harald

-- 

Dipl.-Ing. Harald Mommer
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone:  +49 (30) 60 98 540-0 <== Zentrale
Fax:    +49 (30) 60 98 540-99
E-Mail: harald.mommer@opensynergy.com

www.opensynergy.com

Handelsregister: Amtsgericht Charlottenburg, HRB 108616B
Geschäftsführer/Managing Director: Regis Adjamah

