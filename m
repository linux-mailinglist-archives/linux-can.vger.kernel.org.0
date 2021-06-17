Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A73AB36F
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 14:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhFQMYT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 17 Jun 2021 08:24:19 -0400
Received: from mail-eopbgr70115.outbound.protection.outlook.com ([40.107.7.115]:17222
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232797AbhFQMYQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 17 Jun 2021 08:24:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoMN2qtX7HFhX0acZTefrLgle4KsEmtsF6sn8dVSc/xv1Vn00eeBQ3FFGCVRW6QHiMUO6GNshzD8ivOnTTN1m55Jadcir7Dq2F42oBf33v8asYE6LxvnPn7fygKVgboTbmtOlA6eci6TCYsRICcKNO2eMQXzjqY7txFo7PFM1iN7agWoQf+sx+LgEDIRFnsa6DgMLA3oy1nmyNbnoeNAVFpAs6Px/SeuwYF+8+1mOArsaiaYGh+AvF05oxW5ztuNieE/t+7k4TUbX4K+B9OGcG2c9XF+vtmwU6W2I+ofCOVXMgJs73vOcv/HXx3i8GlSYobeoXpwMBHSt0u/uGwphQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0epvuwCNd81hEo0ErkzfVRYw60SD19WaRI3xUqpChA=;
 b=Rv+x0zAClAdBT+0w13UZ1fbyk0bwP3E2Y7b2BJ2oxdyyfjt0U2m7jECHsoUxQ73vzoy7frY/ldReDr/2MJYYlWNrzr71aNXAs1Z0KJBcZZzH5UhUNrqAJrJg/iFhKawPCa+Z5E0vLtR2dBGcNShcHqN1pFxtcCx0ZK2KncwY5yik0jLKU2mWxGcpv2a8fwO5PEYfXFm0DR5QffXhnS5InjN0JvpsfQOx2x8fLW4SzVyB3GRXwtXVSHkjCX/ywNQbk/pUb/Dd/+0SmSeEEhbTRoDOavB9HM8dtmyK9ud31h69p4G0SjuGnMUZqUqp7WWg2frWEv6r2ArsRfRtNnZoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0epvuwCNd81hEo0ErkzfVRYw60SD19WaRI3xUqpChA=;
 b=BWwg+LRxIw6rZyOssezOCrf5nZFy1zqVVrwkxwo9pfW5PJEw6cKPn9FoVNLPtr8f1TLsxruj0rLkz95L0QKPCuosS/aBAZgML35d2YkFe8cb19KHBEg/T5oUzKyT/V3XdU673cvUySo6c1QAg9VVkiK6ORDzmX3a7WHtHVQu1vc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=opensynergy.com;
To:     linux-can@vger.kernel.org
From:   Harald Mommer <hmo@opensynergy.com>
Subject: MSG_CONFIRM RX messages with SocketCAN known as unreliable under
 heavy load?
Message-ID: <c3fc258b-2f62-74ba-ca41-e6f839930020@opensynergy.com>
Date:   Thu, 17 Jun 2021 14:22:03 +0200
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0902CA0019.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::29) To HE1PR04MB3177.eurprd04.prod.outlook.com
 (2603:10a6:7:24::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 146ad1e0-997c-4b4d-f7d2-08d9318a849d
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2553:
X-Microsoft-Antispam-PRVS: <HE1PR0401MB25531F8FE723AC574BDAB5F6E50E9@HE1PR0401MB2553.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CHMpBKHa74vDAsy3YPVEXSwgKIBi2Oi3DE7eZa1Mx8NoA92thqsGC7DkrYWcCiiOttUCDElZ0o3IKOmQ8cYACib9s0UwLSTkKaU8J1aZ99HEDQ+2FQXA045rwo5PRBT4hlaPEc0RAVKaZ/FcdA7gzjfaSCX0+VwXR5lDdsJPnv5ER7Ec21VCfPgjWwYqjA0nJ4rSRjl+WVfqLpSEwl8ZiUmcoIVuytpB3KkkOyPIv6CweX5BbUmt9C/iBvX+9ledbfDZPx5A5/TgNR6xT589JKASfhADspgMq5r0NMQ/ED+149kFXf9j/Ls0aH/jUVgyVbgCk6oCkAMI4o2w2ebMAknrtYkCZv0L2wyp99zi9yHmLvmYM2FrERsiSL8tVDmnXcPJxU7fDviizn+otqia6eluP6uV/TI994TppbmQvVoZ98ZSNHJkEUy8z5YGExdqNLCOsSpfYEjtupJzroTMRmYAAzEpgEf+QCXd1d7KCe+EEwoFk1aUQKfc7/0/MDZPmyDcq3TYF2sQuDDa+rucKMBApiB6WsHoFY4NHs8wffUnT414PEFw7TQop87te4Cgd6wE1BUJqmZgS2haS9UHsdWDEV1Y3kmD0JJuatVeh8XaveWiOENgWZkbX+BmIRWw7VnO6NevdfBFkkLYOiQvBIV9cEXCf7GHCXlN1YJYM26fxjAWnOBGMJ5g26h3PvJm42RCp+po6T1odl4pCZRTJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB3177.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(366004)(376002)(39830400003)(396003)(2906002)(26005)(8936002)(478600001)(31696002)(31686004)(15650500001)(66556008)(186003)(66476007)(6916009)(316002)(8676002)(42186006)(66946007)(5660300002)(83380400001)(36756003)(2616005)(66574015)(15974865002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNUMmd2a1dqUFg2RjNMUkNrM1psUEowWHY4RExmTFpNcC9YMThmaDlKSldZ?=
 =?utf-8?B?K2cvaFZneld4eVl6T0RmVlJ1cEorSStTMU0vRHBIcWZraExpUVdEUUZMUEhP?=
 =?utf-8?B?aWlVOGdFcTV6cmpLRVZUQk9RemFkdVR0Q05lcW9WT2J6RUV2a2FsRkgrRGVs?=
 =?utf-8?B?WUdaeDVoczRyZ29QN1lDbXNiaFQvWkxlVUlZcDhiWm82R3pmay9kT1pXSGxJ?=
 =?utf-8?B?U3lJRndMVkZjcGt6ZW5pYU40VHV3dWpzdTVtZFEvS1ZwUW9BR21lajNHcThk?=
 =?utf-8?B?Z1M4TDczSkhBaHBsV3NJanZ6T05ST1YvTmxrMk5GTHV3WVpST3d0b3poeEN1?=
 =?utf-8?B?TW5Pa3orenZtUmJVTDFKcVFiNit5QTBrbWhadytCSVRQMUxYMU8rUmtaZHVG?=
 =?utf-8?B?eDg4MDczcWM3VU8zVndwekdGeHJaRm5KY05pMGxDajZWS1g3dnk5UCtWb2NG?=
 =?utf-8?B?V0Z4ZGgyZVppQkd4UVRIVkRmQnBEbHQva1IxWjJXYnl0OEY2Sm1FSDE4RnhW?=
 =?utf-8?B?TEM0dHBrTmhvRVJMRHFaSXNPV2ZjakNFVFRCQlhyWk9ZcVVLbktqNjl0Q0JU?=
 =?utf-8?B?WjZMbnQ5TENiZm1LK1VxSmNiRHZtMUNzVm50L2JnZys4M0dsSGJDamxrT1Jr?=
 =?utf-8?B?L1RLRjd1TkZoOEpIdWFOeS9QTHlIbkg0SVo4S3NUVEd2MFpUSTdvWk42TUJy?=
 =?utf-8?B?czZTekN0eFRpYlM0ajdxL2NYS1lTcVdsQUkrYldjNXhXcE8xbXhSRWgxa3Ru?=
 =?utf-8?B?RnVCd2ZiMit3YVVPWnI1STJRNE9saXRmWXRaOFgvYk8ydUpkNWJtMGRVV0tC?=
 =?utf-8?B?a3ZVbktkLzgyM01yWXNKOWpqd3Q5MW1YWVJxM3RWUmk2Y0NJVi9ZaEZkdG80?=
 =?utf-8?B?Vm5QakpnSDBWamVqTU9aM2tPYWxJaU1sK1BoS1IvWlFobVNXWm0yMUY2UFVF?=
 =?utf-8?B?V2J5aWttbGhuK2dzcVBQSy9TRmlTT0NZbVdkVUlkQ2VSM1Mya1U4SGNvVjd4?=
 =?utf-8?B?VHZJY3owU2c1Qm56U3Q2clQ0MVFVVkwwTDZLb3lQd21tdVkyeHFhUzVzaGFZ?=
 =?utf-8?B?YkxZSHF2SlZiL1NFa0hrUWc4OHprWmhSLzZMQmQ2Sm9iRG9CaXRDeDZ0U1F5?=
 =?utf-8?B?bHpMRlJ6N3lqdXV4cG4zcUlMUzVmaFRTWDJQU3ZqbUJMNmFGbEswQ0pVdFBI?=
 =?utf-8?B?dnpJKzEyZHRXY0lEV3FocGJ2MDYrdDBTQmw2K0lzeGdhMHpCOEsvWXZIOWI0?=
 =?utf-8?B?WWdVdFVzZkhZSlZBeTgvSUR1Y3ZvZ2NmTWxiOEwzbUhwSmhwSnVNWUE3cFpY?=
 =?utf-8?B?QTJnUUhpSGlnUjUwUW9zOFhwRWpiWUxaSmxXaFRwNlVBUlFrUzFJSG5kTFN4?=
 =?utf-8?B?SjUzYTJrK0haN0h0RzhrZVk4ZktXZWZmVEVoMGRqWFBiLzM4bkJkNXpHK1dL?=
 =?utf-8?B?WG9pWGdNR1dyY1ZZdTJ1aERMU0xJZWdqRjJ0M242ZDZWcS9iOHNEUlVvT3N4?=
 =?utf-8?B?TG0wWXo2SmwxN0RkVk4rOFRhR1Nzc2RKS3pjZDVOTHdDL2dSb2F0Z2IwQW5D?=
 =?utf-8?B?T0hMbC8vdXBBVWpQNVJCU2V6eTRnNVJ2c0p2RE96eGxRSTAwVEt1bXZjWlM5?=
 =?utf-8?B?WENWVU05K1pFU25Cb3V3MGpmQ3lPaUd2dFM5OGwvck9KNXFkSlUrK3U1YVV3?=
 =?utf-8?B?YWRCaFFYdFBIWlhLU1JOZlVYRmRMc0UxTEJUd1c5clh5SVRSMHd4TVNNUjBO?=
 =?utf-8?Q?9OGXZfABIycS5xCfehwWMdp2Dq2foNnsovX/E70?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146ad1e0-997c-4b4d-f7d2-08d9318a849d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB3177.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 12:22:05.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXTg6D6tJM38VBrT6F2yvEnnnUTwSb/sR5J1lEJQuhtSFqb397nT37cb7B534Lz85ttRDKJThORhsKZTAvQC+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2553
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

we are currently in the process of developing a draft specification for 
Virtio CAN. In the scope of this work I am developing a Virtio CAN Linux 
driver and a Virtio CAN Linux device running on top of our hypervisor 
solution.

The Virtio CAN Linux device forwards an existing SocketCAN CAN device 
(currently vcan) via Virtio to the Virtio driver guest so that the 
virtual driver guest can send and receive CAN frames via SocketCAN.

What was originally planned (probably with too much AUTOSAR CAN driver 
semantics in my head and too few SocketCAN knowledge) is to mark a 
transmission request as used (done) when it's sent finally on the CAN 
bus (vs. when it's given to SocketCAN not really done but still pending 
somewhere in the protocol stack).

Thought this was doable with some implementation effort using

setsockopt(..., SOL_CAN_RAW, CAN_RAW_RECV_OWN_MSGS, ...) and evaluatiing 
the MSG_CONFIRM bit on received messages.

This works fine with

cangen -g 0 -i can0

on the driver side sending CAN messages to the device guest. No 
confirmation is lost testing for several minutes.

Adding now on the device side a

cangen -g 0 -i vcan0

sending messages like crazy from the device side guest to the driver 
side guest in parallel I'm loosing TX confirmations in the Linux CAN 
stack. Seems also there is no other error indication (CAN_ERR_FLAG) that 
something like this happened. The virtio CAN device gets out of 
resources and TX will become stuck. Which is not really acceptable even 
for such a heavy load situation (-g0 on both sides).

Is CAN_RAW_RECV_OWN_MSGS / MSG_CONFIRM known as being unreliable (means 
MSG_CONFIRM messages are dropped) under extreme load situations? If so, 
is there a way to detect reliably that this happened so that somehow a 
recovery mechanism for the pending TX acknowledgements could be implemented?

I'm aware that "normal" RX messages from other nodes may be dropped due 
to overload. No problem with this.

The timing requirement originally set (done when sent on CAN bus) has to 
be weakened or put under a feature flag when it's not reliably 
implementable in all environments. But before declaring as "not reliably 
implementable with Linux SocketCAN" I would like to be sure that it's 
really that way and absolutely nothing can be done about it. Could even 
be that I missed an additional setting I'm not aware of. But the 
observed behavior may as well be something which is known to everyone 
except me.

Of course it can be that there is still a bug in my software but checked 
this carefully and I'm now convinced that under heavy load situations 
MSG_CONFIRM messages are lost somewhere in the Linux SocketCAN protocol 
stack. If there's no way to recover from this situaton I've to weaken 
the next draft Virtio CAN draft specification regarding the TX ACK 
timing. As this has some additional impact on the specification before 
doing so I would like to be really sure that the TX ACK timing cannot be 
done reliably the way it was originally planned.

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
