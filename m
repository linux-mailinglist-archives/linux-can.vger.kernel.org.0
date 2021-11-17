Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDD2454F4D
	for <lists+linux-can@lfdr.de>; Wed, 17 Nov 2021 22:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhKQV1p (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 17 Nov 2021 16:27:45 -0500
Received: from mail-eopbgr20105.outbound.protection.outlook.com ([40.107.2.105]:32636
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231834AbhKQV1n (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Wed, 17 Nov 2021 16:27:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkMwfTYoSRGYB8S1FDDkCcEW/B0ZMwie9U/EVitGKiEmo/aumUXJcYXG3mkmItC1eht2AOy2QAacI50n0EH13Vt7oqb9yZoLIe+uVmjt2gbgaWCPWfQdKF9Amr/uGJvkP3KAO0+bDpm6AfCW+BKkW7tuzqDZtTvF0vFzGAzrSN4EtqpAwPmTWhcCGzj+qSunUch1UrykJc9F+Ev0nE0JhrQ8QEn9SPyBPQptNXpHuLChScwy5l15G4ScDVfn9i8v8cQG9k+r4VqKPycMXrd16ucGKFnePL5G894qDErjsfc3PjaXUfTgxcuMH0DyBxEV+z1vA+q6yGGWLIwNZPCsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yyi2A9i1eZ6TsMLDnr/CdU6vozpfH0SlGKt4tmqQOJc=;
 b=OH9s1RseWjIEn+POpeF/KaP4v8/Ew9yzcGLcfPJACDzncA1vGH+tkOgaraD1DK80Cp+RLNpGAOKoW0jh/nNUQdwEr6tcKtVOxYlz2bMm5HFUPSkrNOtxmCIN0tleqpdYx6ZuwovCvSvN2/MbPV5zGO5lZBbK6GgmhEnAcm71iRUcJC2Nf+lDuV72zAG5ifVq8I1qyiTrtXplqMe5ACqbExaS1/vsBNZrvevKCz8C6mESe+SCXWjpHectyO+9v999DOeFQWpFGUGGIvGwE23zRxH2GRgBACkxGhCJKX7+MabmCnl3n2ZIWvsVGb4HHVuTZbTzWwDD9gQutotqZ/rNQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yyi2A9i1eZ6TsMLDnr/CdU6vozpfH0SlGKt4tmqQOJc=;
 b=SKzLQnm3/WYj9ao7DMo/QQXY3tBGxLbZOr7JF3vN06hHPTFbeC7M0PeXj4Msa94At028DIe/9CRADcW2T7nsP9rl2+f4fuC26LBrFS4AZGgPRPku20u0XHKlfq93LW5+0AoOH9mhzn8k8eR+Nw3lUKi6YVFOiL2TQDchmU0mh7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DBAPR02MB6261.eurprd02.prod.outlook.com (2603:10a6:10:193::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Wed, 17 Nov
 2021 21:24:42 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::b1d6:d448:8d63:5683]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::b1d6:d448:8d63:5683%6]) with mapi id 15.20.4690.027; Wed, 17 Nov 2021
 21:24:41 +0000
Message-ID: <b8b0c7c4-3006-071b-d68f-8b18d24a1f72@axentia.se>
Date:   Wed, 17 Nov 2021 22:24:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
From:   Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH RFC 2/2] phy: phy-can-transceiver: Add support for setting
 mux
To:     Aswath Govindraju <a-govindraju@ti.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211111164313.649-1-a-govindraju@ti.com>
 <20211111164313.649-3-a-govindraju@ti.com>
 <20211112084027.b2t2beqiiodnwjtv@pengutronix.de>
 <085ec3c0-75c6-f3c2-9999-348098fd88f9@ti.com>
 <f933048c-099f-054a-6563-671cf2a2e2af@axentia.se>
 <8be2b770-9c4c-ce41-4c49-27fa30b4afee@ti.com>
Content-Language: en-US
Organization: Axentia Technologies AB
In-Reply-To: <8be2b770-9c4c-ce41-4c49-27fa30b4afee@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0035.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::9)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0035.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend Transport; Wed, 17 Nov 2021 21:24:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff4577f7-0ab4-4feb-c73c-08d9aa10ab1e
X-MS-TrafficTypeDiagnostic: DBAPR02MB6261:
X-Microsoft-Antispam-PRVS: <DBAPR02MB6261E5CDC234C9BA2206A79BBC9A9@DBAPR02MB6261.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+Qn7ugQjRQSpiogMLCxpuUavfeZWi6TlTR8TR90eNlixyY+P78Ba/gxXngzaXY8n/+PKjl8SSLiSLoCX5jjVOmGxjJwCCEpm8dlNjJA7qp/vzUiMry/xUm7hIewOX8GLZXNx5pNDFKZRJbtosoUl9VB6nsFbw5jFX4yScwGxqkkD0lo3YhcPuL8+dETmQhGng9VNLv/o9BcGrzMvNLIfJk8cXei2qNTN9Tb9WmhnUwc1ALp2xeiOYiZaEAIjZnfEk+ksT3WYfqNn6Jwssv2j3XuI+2Yl0UtV24Br9nXK8BVk3D1NqMr33vStywF2StnKCfvLGfs+hj6MgfGfp2kIZFhXT8YDRkfC1BIERNjaAr8rOdluOixjEsHb+VXviBX8zqj418colRloUGGn7/hjWNjj2edc90asyxiPLPn40bMvoE6K3GQNWq4/ZGu7vkHsoljsD+Cm8/Zy+8RDEnEwXKIma8E0wVt8zKSHgWnnqtkFVTXRynLv0Euf6MAj46OLE/UG6+1CQBV66LA0wlJfxAXFM/3cuLOz6DriTngtCPJve4Keqce3G7VF63fdi7XyzDdBVhh05oy+tBlcbSxrxDaL4hGq7hpmO0Ikakg3zQlOHOgSyEVBNYTFCYkNHIunnE0ysLwTyglpR2/uJ88HY+gv+vmn3boyQ1ZXQENHwYuzmJXObBZniwVBf/N7sDDZae88FcRXW8TNxZsEGndk2uMCh0nzll4IPYpyk1D4Z4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(366004)(39840400004)(376002)(8936002)(5660300002)(66556008)(66476007)(66946007)(6486002)(26005)(8676002)(83380400001)(316002)(7416002)(956004)(31696002)(2616005)(4001150100001)(38100700002)(36916002)(53546011)(36756003)(86362001)(508600001)(186003)(2906002)(54906003)(110136005)(4326008)(16576012)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K05hRFVMRWxkMXFJZk83a09FQ3B0REJVWUo1STA5cTJiZzVBWkhWaEl2OXRi?=
 =?utf-8?B?QjNqb2x4aFJFUkNxZ3czM3dqUFdsWERUakxjZENyelVDL2l1VHJETFg4RUV0?=
 =?utf-8?B?d0JuclJFYjB4dVhITnBPUlpUQ0J4eW5Lbng5S2FQN2F1aW5FOHJTbnVHZjRo?=
 =?utf-8?B?ek5yTjBKbE9aZHdnZzkvaVV6NU40TThqNWtDR0tCYnFoVjRyRGlWV2FHaFF5?=
 =?utf-8?B?SkZGL1lhL0xlVGZRRDFFSTEwcEFVOHlIeDFKUUdIYjdFTWtmUjM3elpET2Q3?=
 =?utf-8?B?Z1djcFdiRjlma05FbE9vdGV3c1ZMWFlGb2ptYnFxU21oZ25VYWFHZGdmeDdW?=
 =?utf-8?B?cXMyNHlTUEtpVTJqazFmMEUvaUlzUXg2UnpsRFZIZUtPSmdsd0k4a1VJK3A2?=
 =?utf-8?B?MjAycU40ODF2bXJLWjlFVlVmNUs5R1BnQ2kya1VLVWdCQWlZcHZ3WHVhdW4w?=
 =?utf-8?B?ZFMxTXlRaVF1ZkQ4M0tOdTZTYXg4aEkyWUpQSXBRRklyRnF3ZFJMclI4Ymo2?=
 =?utf-8?B?L0dyVWs2bkh1SC9KQkt5bkZyR0RWekpPZGJGVE10bG9seGJWSWVhTVFWNWpR?=
 =?utf-8?B?ay9mN1ZzeFdRdU1zMW5zQ0lGWFA2WGdVT0ZzaGMxRjF3UU51ZWoxZXdWeC9x?=
 =?utf-8?B?RkZjS0hvZmYrbVh6MGtzR0xaZTBEQXdGZjJnVXB5Mit0Q2ZEMXNoZE9mT3BH?=
 =?utf-8?B?MGp5OS9wYzlkTThKL0ljV0xpZ3NCeG4vejlvUC9jQWptc2k4L0lhSmlmRFBz?=
 =?utf-8?B?M253bVFSa1A0VFdCNVhWWlY3MGpmWWNVeDJOajIxdmVtbXVVLy85dUVTUlor?=
 =?utf-8?B?QTNOTjc2aEh0bjQxVXJxdnN6Rk9zYkptQ1dYbHdpTVRtQmRhWFUyaEliWTFD?=
 =?utf-8?B?SlE0NjFhODU3TndSZkRiSFJ5NzAvU2VMa1M2Tmx3UWdpMUF2ckVONzRzNWJw?=
 =?utf-8?B?aENqWWFPY01mcmd6OVBjazYzdCtBOFRVK3VUdWlCZWhFQU94eEg3Sm1KVENM?=
 =?utf-8?B?ZnBVc1JQbk0yRHZYL2tFREgvM1o5STk0OEMzb3VlRG84QlcrZE52cmxramIx?=
 =?utf-8?B?MWRLTUI1WVo4VUxIVDZjMC84eXJQcENBZFNZT2RGYzJzTEFrUkNNNGprdjdi?=
 =?utf-8?B?bEI1Ym8rb1RXSXBJaTJHeVZ2ZlBIME1ZcElyN0pqL2JIbU5sRDdtZnI0ZHYv?=
 =?utf-8?B?TlJuOG5YK3ZkbnZ1cXQyQWxIL0QyNFR0Snpsb3dhYW1hSGVVN05GSHFYeTdD?=
 =?utf-8?B?S0lkbzhiVXV0MzVPWHVhd1I0OXJreUlHdW0xT1BvcFUyZ3NvakdxRUtiNmlM?=
 =?utf-8?B?b2lwWmFjNjVLUkk4MklRVlJtUjRnMXMzbzh6S3BuTGZPUm02dFZHMGVUOVFn?=
 =?utf-8?B?M1B0WjRzZTV6YXFKYUFKNjhkQXVaR0tTWXIzMnZRSTVWRnFhUURPdGtIVEc1?=
 =?utf-8?B?RGJ4em5IUFlZYmRxbnFXOWlJUVRtT3d4RGN5dGkvcVlqcTUzdTdEMWY4Zm5E?=
 =?utf-8?B?NlR2NXg5NjI1VWlJSjBIdFNpamg2STR0ZmJaZGhlVjd1S0x4ZWVvQzY0S0d5?=
 =?utf-8?B?SU92eHVTSG90bmV5TGc5bTFucG9ma2kwVW1TVEN0ZTE2RVpSUk14YkRCazJX?=
 =?utf-8?B?UWNMRDNURE8xdUtCZ002NzBpMmFMQm83OHh3VTNWcE9XN29QbXAybGdrTEFt?=
 =?utf-8?B?dytMQlAybEl6V3V0R2EwMXhvMXlDc0lPNkpmSmJmSlF6TmRKdUpJUEozQWVF?=
 =?utf-8?B?MzdyOXhHOVZCSGI0Smx3RW9UeXFVMlN0d1dQTGMzZkdpYmFuTWVxMU1sRHhV?=
 =?utf-8?B?SEVhbXdybGMvOUtUbXVwckkySlErRTB3MEw0TWVVRUxLZ2J5MEdpSmd0aUpW?=
 =?utf-8?B?U3RhM1BxSFBLdmhheHZsaERtbUhpRE5KMWxoVHk3MXdRSzh6MHdLZnZYbXpj?=
 =?utf-8?B?S1dSZVY1VHhVL0xWV3k4cFBLUWZBeXdtUlJQWWRDOWxTYTlNOFRzQlh6NlBk?=
 =?utf-8?B?TG12NlBzS2d1WVUraEFzU3F2Y3o0aEYrMTFtblFtNlJhQ1UwVC9FYkhhTFhN?=
 =?utf-8?B?ZVk0YmpaV053YThmZkI5b2dhbkdlMnd2eDF1dmVCVVJBbG9saUxzZXY3cjNK?=
 =?utf-8?Q?7d0Q=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4577f7-0ab4-4feb-c73c-08d9aa10ab1e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2021 21:24:41.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjWZlQoTagU384HResClDM+3bBU62dp8vcgzscOXe1kFwRxNjsDIfensb27ciaXO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6261
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!

On 2021-11-15 07:31, Aswath Govindraju wrote:
> Hi Peter,
> 
> On 13/11/21 12:45 am, Peter Rosin wrote:
>> Hi!
>>
>> On 2021-11-12 14:48, Aswath Govindraju wrote:
>>> Hi Marc,
>>>
>>> On 12/11/21 2:10 pm, Marc Kleine-Budde wrote:
>>>> On 11.11.2021 22:13:12, Aswath Govindraju wrote:
>>>>> On some boards, for routing CAN signals from controller to transceiver,
>>>>> muxes might need to be set. Therefore, add support for setting the mux by
>>>>> reading the mux-controls property from the device tree node.
>>>>>
>>>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>>>> ---
>>>>>  drivers/phy/phy-can-transceiver.c | 21 +++++++++++++++++++++
>>>>>  1 file changed, 21 insertions(+)
>>>>>
>>>>> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
>>>>> index 6f3fe37dee0e..3d8da5226e27 100644
>>>>> --- a/drivers/phy/phy-can-transceiver.c
>>>>> +++ b/drivers/phy/phy-can-transceiver.c
>>>>> @@ -10,6 +10,7 @@
>>>>>  #include<linux/module.h>
>>>>>  #include<linux/gpio.h>
>>>>>  #include<linux/gpio/consumer.h>
>>>>> +#include <linux/mux/consumer.h>
>>>>>  
>>>>>  struct can_transceiver_data {
>>>>>  	u32 flags;
>>>>> @@ -21,13 +22,22 @@ struct can_transceiver_phy {
>>>>>  	struct phy *generic_phy;
>>>>>  	struct gpio_desc *standby_gpio;
>>>>>  	struct gpio_desc *enable_gpio;
>>>>> +	struct mux_control *mux_ctrl;
>>>>>  };
>>>>>  
>>>>>  /* Power on function */
>>>>>  static int can_transceiver_phy_power_on(struct phy *phy)
>>>>>  {
>>>>> +	int ret;
>>>>>  	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
>>>>>  
>>>>> +	if (can_transceiver_phy->mux_ctrl) {
>>>>> +		ret = mux_control_select(can_transceiver_phy->mux_ctrl, 1);
>>>>
>>>> Hard coding the "1" looks wrong here. I have seen some boards where you
>>>> can select between a CAN-2.0 and a single wire CAN transceiver with a
>>>> mux. So I think we cannot hard code the "1" here.
>>>>
>>>
>>> Yes, as you mentioned it is not ideal to hard code "1". I feel that, it
>>> would be much better to read the state of the mux to be set from the
>>> mux-controls property. The issue that I see with this approach is that
>>> the current implementation in the mux framework only allows for one
>>> argument, which is for indicating the line to be toggled in the mux. If
>>> more arguments are added then an error is returned from the
>>> "mux_control_get". I am not sure why this limitation was added.
>>
>> The only current use of the first argument is for mux chips that contain
>> more than one mux control. The limit in the mux core is there since no
>> mux driver need more than this one argument. The number of mux-control
>> property arguments is fixed by the #mux-control-cells property in the
>> mux-control node. I don't see any way to and a new optional mux-control
>> property argument that specifies a specific state. How would that not
>> break all existing users?
>>
> 
> My idea was to use the second argument for reading the state of mux to
> be set after increasing the #mux-control-cells value to 2. I don't think
> this will break the existing mux controller users as the second argument
> was not used till now, would be equivalent to adding an additional feature.

Ok, I see what you mean now, sorry for being dense. If we allow this then
there is a need to add a special value that means all/many states (such as
-1 or something such) so that a mux-control can be used simultaneously by
drivers "pointing at" a specific state like you want to do, and by the
existing "application" style drivers that wraps the whole mux control.

I.e. something like this

	mux: mux {
		compatible = "mux-gpio";
		...

		#mux-control-cells = <1>; /* one more than previously */
	};

	phy {
		...

		mux-control = <&mux 3>; /* point to specific state */
	};

	i2c-mux {
		compatible = "i2c-mux-gpmux";
		parent = <&i2c0>
		mux-control = <&mux (-1)>; /* many states needed */

		...

		i2c@1 {
			eeprom@50 {
				...
			};
		};

		i2c@2 {
			...
		};
	};

Yes, I realize that accesses to the eeprom cannot happen if the mux is
constantly selected and locked in state 3 by the phy, and that a mux with
one channel being a phy and other channels being I2C might not be
realistic, but the same gpio lines might control several muxes that are
used for separate signals solving at least the latter "problem" with this
completely made up example. Anyway, the above is in principle, and HW
designs are sometimes too weird for words.

> One more question that I had is, if the number of arguments match the
> #mux-control-cells and if the number of arguments are greater than 1 why
> is an error being returned?

Changing that would require a bindings update anyway, so I simply
disallowed it as an error. Not much thought went into the decision,
as it couldn't be wrong to do what is being done with the bindings
that exist. That said, I have no problem lifting this restriction,
if there's a matching bindings update that makes it all fit.

>> The current mux interface is designed around the idea that you wrap a
>> mux control in a mux (lacking better name) application. There are
>> several such mux applications in the tree, those for I2C, IIO and SPI
>> pops into my head, and that you then tie the end user consumer to this
>> muxing application. The mux state comes as a part of how you have tied
>> the end user consumer to the mux application and is not really something
>> that the mux-control is involved in.
>>
>> In other words, a mux-control is not really designed to be used directly
>> by a driver that needs only one of the states.
>>
>> However, I'm not saying that doing so isn't also a useful model. It
>> cetainly sound like it could be. However, the reason it's not done that
>> way is that I did not want to add muxing code to *all* drivers. I.e. it
>> would not be flexible to have to add boilerplate mux code to each and
>> every IIO driver that happen to be connected in a way that a mux has to
>> be in a certain state for the signal to reach the ADC (or whatever).
>> Instead, new IIO channels are created for the appropriate mux states
>> and the IIO mux is connected to the parent IIO channel. When one of the
>> muxed channels is accessed the mux is selected as needed, and the ADC
>> driver needs to know nothing about it. If two muxes need to be in a
>> certain position, you again have no need to "pollute" drivers with
>> double builerplate mux code. Instead, you simply add two levels of
>> muxing to the muxed IIO channel.
>>
>> I think the same is probably true in this case too, and that it would
>> perhaps be better to create a mux application for phys? But I don't know
>> what the phy structure looks like, so I'm not in a position to say for
>> sure if this model fits. But I imagine that phys have providers and
>> consumers and that a mux can be jammed in there in some way and
>> intercept some api such that the needed mux state can be selected when
>> needed.
>>
> 
> Yes, I understand that reading the state of the mux in drivers would not
> be efficient as it would adding the boiler plate code in each of the
> drivers. However, for phys as each of them can be used for a different
> interface, I am not sure if a common mux phy wrapper can be introduced.
> This is reason why I felt that drivers should be allowed to read the
> state of the mux directly, when no mux wrapper application is suitable
> for it.

It need not be one grand unifying phy mux, it could be one for each
kind of phy interface. But again, I don't know much about how phys
work nor their interfaces, not event roughly how many drivers there
are etc etc. I have simply never needed to look.

Hmm, wild idea, maybe there could be a mux "application" for pinctrl?
I mean such that you could tie pinctrl states to mux states. It doesn't
sound like too bad of a match to me?

Cheers,
Peter
