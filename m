Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCAE44ED22
	for <lists+linux-can@lfdr.de>; Fri, 12 Nov 2021 20:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhKLTSp (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 12 Nov 2021 14:18:45 -0500
Received: from mail-vi1eur05on2106.outbound.protection.outlook.com ([40.107.21.106]:33056
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235265AbhKLTSo (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 12 Nov 2021 14:18:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tk2FtlLhk8m9B13b4wEG4HICr1YLy/n7TKeYPtPRGwnkPRk4M6OhKAwf1B66ucDh6djDjlFRDzeT+gzIFOXgWj7/XK6+Ja8xxfcYM8Gvt6mPaiqHmJ7ghNnayPvYKILViU/ChY1yPObDMe1eU91CQ8jMUhNCXX2bVRo5tjm1+/C+Ecjrkf4oUyr3L74c/9mBD9wUA05xx0lspjUiAl1cn/0DI7xepMJLsvf7wZKCVm9J9NS2jZZWjY2ylBfgxpj97n175HJmQ+Quy20+PReqJ9cdwcqhYvFnWOU+E/RO4Vq4rAtTAmMXE7TujLjmIRAc40A5vaKPW2yrhpMvyrqr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVlpReT9vCWvJGSVpmHJGbVkWymjCKkNEkgJRKVzF88=;
 b=M8Kfait0CQ7+xIQ3efmqV60djO/UfsrLQXiAigVeka6+p7/Waey5maqVcfNx+au8XONMj5z1V/XhgZe5VGoJ6V8HEo3qQKVp1ml926JHxv3UC5xEeBJHDHDc2aK4exbHzRXsb7K8Fddprzt9MK7oUTgsubTdz6FA5m93Tflp5PWteFFhTn1QettoCXMcJHDgmnqxOsFm412ogaLohEnUXsKRp/OUtV0ehF2KOV4oMhO9M6Ev3x+EIm6g4C6LvB8pA23SnIwo8VRiEpZoYVIgNjvWTMTVLVVngXlPJPJcRd+mP4BG1d6EAJGNwHqQISM88YXnEJRA8IOEQww3LSIrMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVlpReT9vCWvJGSVpmHJGbVkWymjCKkNEkgJRKVzF88=;
 b=BfH9O3Tn6KCl8oQv28piMOU9L7JeUr0WHj0P3HQAdkPmB+Rz542+vt7VVlxF9mM+3NYL31+ysIXqaXJUN/MegBPaRuq/wfmpa8rkCJZYmcAQQ6ulmN4N3l+lteC54qOpSEn+KL6t44mXD0Zmgb8hXxPZpTGRF2OAAdbFoULbefI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB5001.eurprd02.prod.outlook.com (2603:10a6:10:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Fri, 12 Nov
 2021 19:15:49 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::b1d6:d448:8d63:5683]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::b1d6:d448:8d63:5683%6]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 19:15:49 +0000
Message-ID: <f933048c-099f-054a-6563-671cf2a2e2af@axentia.se>
Date:   Fri, 12 Nov 2021 20:15:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RFC 2/2] phy: phy-can-transceiver: Add support for setting
 mux
Content-Language: en-US
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
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <085ec3c0-75c6-f3c2-9999-348098fd88f9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0038.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::16) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0038.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 19:15:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e08b80b0-2ad9-48e0-71e1-08d9a610d63d
X-MS-TrafficTypeDiagnostic: DB7PR02MB5001:
X-Microsoft-Antispam-PRVS: <DB7PR02MB5001573C5CE6AE675E0E6E5BBC959@DB7PR02MB5001.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49HW1PjvY99vk50IXmfCesR5LfkduzjwiVIeh+KxQ6USqtBZYuS8YL1gdXZr87qZSyBGxz1P+tmm5VUPgczccepvFiUzZQOG12qSxQyJrM+DPVUrfcVM1TSidmzniZqyuiA6BRUO9Nu2onXAqVm9YaEkLQuR5upNrP6gnWbo+/Pxfym97z/n1B0bqRM+lYyahyvYC54aOHqMpQY/oAucB+ra8k+DfA18E5waKItqKCA7t2GPt/Zwhuu/vdtOHE9bPzPWLmVZ3hpKsIqnu+ofSH9jHFBoF/yEB1pG+7HRL/Cutx4A8FZuZ1gtfeH+DHGy06rj3BM9kXNUUI7+sX4K3ZXR+kiQV1QVvG4hC6ye+SG7woZuuBIIy+FO2Rm9DQa94JhMC6VF7lOnLDY5WSBYKcJAql5nNPXwlh0GME4CWsOOwpwg1LLMN88GSHHIKpZCqxS+RBYOdjnc1TBobg0piqngGnyXOhf+M0zWf58Xob8VFksQhW7/s7dwv8w20gPEakNR+F8DMMHU+3OuC83bGzTvZqGm9UaXfyKH/Z5MUwb0co597XWxrcNSY7Y1mIJ4OifL2bGKAlxtVlf/j8OMm9CZ/ccAhe4LBA9xGOa+UDbT+W0jY27anW/8ObKiqUIqM8IY1U6eUXhqLDj23t/wy8GHvwrHIGz+IKQKtSUO8mTG01hbX4GwFBt1Z97NvLt+MfcXHs0UocLDi+XlaeY0zjJEVJogVVqGuZ2g1fmWmlU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(136003)(396003)(366004)(346002)(376002)(186003)(26005)(31696002)(956004)(38100700002)(66476007)(83380400001)(53546011)(2616005)(86362001)(8676002)(31686004)(4326008)(7416002)(66556008)(36916002)(2906002)(66946007)(4001150100001)(8936002)(508600001)(110136005)(5660300002)(54906003)(6486002)(36756003)(16576012)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1JPZEZpVXJDall6MVd1NTNTL3d5dDJkUWw3WFQzT3pNWC9JZnRVbHFGWXJ2?=
 =?utf-8?B?aVpPek5jdm9KMkd0UW9JMzZLbk8rRU41SktZemxTM2ZHOWVXNHNtVklVSlF6?=
 =?utf-8?B?OVVHbGdYUk5hdmJKQkJjK05GMzVUNTFqTTlxNkd4bVNkNlI2UzFLN2FIQ1lw?=
 =?utf-8?B?cThjaUpMRlZGSjEydEpmOWpIMUtKZmx6NkcxSDVJWWJxK3FyQXRKN0hCelpn?=
 =?utf-8?B?WSs1QWZPZCtRem9RbnZvdjZrc1NmcEZFUnQySW1USmszUElES0Z2T21pZDYr?=
 =?utf-8?B?OWRRdDNGTEQ3RjZDV1NsY3pZWWhxcWNKY0FFRk8vZGtCZWoxVmgwWUVoalZY?=
 =?utf-8?B?QlVjLzRiRlJmaDlWWm5YblhoUktHSWdYa1BNeXpWWmUzbHRadGtLbEZlRWdN?=
 =?utf-8?B?SUVTUGg5WVBaS0EwZlpxMUF6Tms0cWQyd29SMkQyN2pmK1V3Wks5TkR6WjI4?=
 =?utf-8?B?R3FuRVE0L3RGU2Zld0w2VlJlWG9JMkJSVFBJNm13VUJPVmNnQnppZ2xTY2VS?=
 =?utf-8?B?a0J1bHI1bWpuenFIYzdta09LdXV0b2cxR1pQOEszOFVVUE16K0pZNk9RbVYr?=
 =?utf-8?B?b2ZMNWI4QmZidUpjMTJPcTdvSWNtbUlqUGM1WnVEVXlpWENPWXNIamE5M3ZF?=
 =?utf-8?B?QzRIVjlaWCsyQ3c5VXV3aVFVSXZxeHRqMm9HKzJ3MUlKd0VPdUl2K3JvTm5v?=
 =?utf-8?B?SUNkYjEvNEhZblR2dGpKRGZNTVphNlhSK3dIdUVINUMyTi9VTTl3MVZRSTJY?=
 =?utf-8?B?eHR6N2NLcnpVNXA0SzlzT2RKV0wvUXVFbmxaUmVpT2l4bWZxMnZWK2Vyb1V5?=
 =?utf-8?B?eWo0d3BKellaZ24vS2Z6bWxVdnJxaC9wdTRSNE80MWNSRWdEcmJsRVdtaVZ3?=
 =?utf-8?B?SE11YS9VSm5HTnl4Ui8rRHJIR1k4NmVyREFXd1V6NTlIQi9zQ2tBQVo5N1dY?=
 =?utf-8?B?K0p4TExpdFEzRis2UnAzZHMzVnJFaFpjd1JNb1lPOUdzS3A4azdOZzdvSUdG?=
 =?utf-8?B?OVRRb1pZQURZbVFhUDlZM2ZnL0xGTERkb1U4NHhRMnZzVmRNZnZ6MysrQjZm?=
 =?utf-8?B?UjY1L3VoS0R1dVdGTUprWCtlUVE1OXpPNzRxd0FiV3J4bW5PdG9ManFMS1FZ?=
 =?utf-8?B?RDNDdTdxWE5HSmJMYUg3c0NpL3hHcmlVUTZBbG1wZE9nTFlUOUYyZy9FMHAv?=
 =?utf-8?B?MTdVVUx4ZTFWOE5wWktlbE90V2p3Nkh0aC9FWVNlcTNUbGdQQUJLVTBRNUhx?=
 =?utf-8?B?YThXWGlaTitUeHpoYmNwdmExSUR3N2pYVysyVUpSVU5rN2h2QnJIWloxVTFa?=
 =?utf-8?B?QllRUUxLb1UxTktyK0FRb1FEYzMvcTllYTdxM0VKNzRZZkh2bTlERHltVWZr?=
 =?utf-8?B?c3k0UzBMaWdScVJLa01sMEt1Rm5kdHdDRGtwRnorc3V6c1I0UXhyWGQzbWFY?=
 =?utf-8?B?dGJIWFpnbnJ2V25SODQ1cExVK29xbHhGT24wcmttNDgremtkLzlIWEpBVG92?=
 =?utf-8?B?Ulh6TDYyQk5seC9PTFV0cjl3YnJQbmEzQkp4UWlUQVNSU0ZlaWtZc25lMVVK?=
 =?utf-8?B?dFpwVk50NGhDNFBsRm9ZTmFHSmw2b250UjRoVWNtOWFRbEF5a1FzV3MxeGM2?=
 =?utf-8?B?OFE4REdyZjhtK3l3T1huSVYyOVJvTmNOV1VKdnlGcjBjUHBrSmhVTGs0ZjZr?=
 =?utf-8?B?a2w3ODFsTURLNFRGL0JIUDFxYldvNEx6b2hXZTBRYmVMNFN0cVFlZzhjaEps?=
 =?utf-8?B?WXNneVNBaFZSNjhPUzhuSkorTGhCR1hNQzVWZE9JNGhVbmFmY2FscU1SY1o3?=
 =?utf-8?B?cnZ3QlhVdlc4YlJOZzh6Y3pYWEx6djY2cVZyQmtHYmhRaWNNSlBRQkU0N3ZF?=
 =?utf-8?B?a20xc01uTjBoZFUzaUxRazhYTmM1MXFHTkhYc29tL0RDNnRiRHViQUJwRGpM?=
 =?utf-8?B?V2xpbGl5dDByQ0Mya0pzMjREV2tidmhoU0didkRsUmY3TitUV08wZklvaDN2?=
 =?utf-8?B?ZHZoaXlUQ2J5bzdDTVF3alpXY0RZMVovMzBLN1JTWVFLTGRZQ0NRdWVDZldT?=
 =?utf-8?B?VzcvSHNNSWxJbzFhM0U2ZUt0WE52Zk9RQzZJWmVNaUdXT3ZzTTRCbHZMUU9w?=
 =?utf-8?Q?lEU0=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e08b80b0-2ad9-48e0-71e1-08d9a610d63d
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 19:15:49.5133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /dfdyH/XdAoGKQHg91mphpiO3m2y1Fq60ii44ce9Cw0F/sqAJQbHQzaKcwC4E77p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB5001
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!

On 2021-11-12 14:48, Aswath Govindraju wrote:
> Hi Marc,
> 
> On 12/11/21 2:10 pm, Marc Kleine-Budde wrote:
>> On 11.11.2021 22:13:12, Aswath Govindraju wrote:
>>> On some boards, for routing CAN signals from controller to transceiver,
>>> muxes might need to be set. Therefore, add support for setting the mux by
>>> reading the mux-controls property from the device tree node.
>>>
>>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
>>> ---
>>>  drivers/phy/phy-can-transceiver.c | 21 +++++++++++++++++++++
>>>  1 file changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
>>> index 6f3fe37dee0e..3d8da5226e27 100644
>>> --- a/drivers/phy/phy-can-transceiver.c
>>> +++ b/drivers/phy/phy-can-transceiver.c
>>> @@ -10,6 +10,7 @@
>>>  #include<linux/module.h>
>>>  #include<linux/gpio.h>
>>>  #include<linux/gpio/consumer.h>
>>> +#include <linux/mux/consumer.h>
>>>  
>>>  struct can_transceiver_data {
>>>  	u32 flags;
>>> @@ -21,13 +22,22 @@ struct can_transceiver_phy {
>>>  	struct phy *generic_phy;
>>>  	struct gpio_desc *standby_gpio;
>>>  	struct gpio_desc *enable_gpio;
>>> +	struct mux_control *mux_ctrl;
>>>  };
>>>  
>>>  /* Power on function */
>>>  static int can_transceiver_phy_power_on(struct phy *phy)
>>>  {
>>> +	int ret;
>>>  	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
>>>  
>>> +	if (can_transceiver_phy->mux_ctrl) {
>>> +		ret = mux_control_select(can_transceiver_phy->mux_ctrl, 1);
>>
>> Hard coding the "1" looks wrong here. I have seen some boards where you
>> can select between a CAN-2.0 and a single wire CAN transceiver with a
>> mux. So I think we cannot hard code the "1" here.
>>
> 
> Yes, as you mentioned it is not ideal to hard code "1". I feel that, it
> would be much better to read the state of the mux to be set from the
> mux-controls property. The issue that I see with this approach is that
> the current implementation in the mux framework only allows for one
> argument, which is for indicating the line to be toggled in the mux. If
> more arguments are added then an error is returned from the
> "mux_control_get". I am not sure why this limitation was added.

The only current use of the first argument is for mux chips that contain
more than one mux control. The limit in the mux core is there since no
mux driver need more than this one argument. The number of mux-control
property arguments is fixed by the #mux-control-cells property in the
mux-control node. I don't see any way to and a new optional mux-control
property argument that specifies a specific state. How would that not
break all existing users?

The current mux interface is designed around the idea that you wrap a
mux control in a mux (lacking better name) application. There are
several such mux applications in the tree, those for I2C, IIO and SPI
pops into my head, and that you then tie the end user consumer to this
muxing application. The mux state comes as a part of how you have tied
the end user consumer to the mux application and is not really something
that the mux-control is involved in.

In other words, a mux-control is not really designed to be used directly
by a driver that needs only one of the states.

However, I'm not saying that doing so isn't also a useful model. It
cetainly sound like it could be. However, the reason it's not done that
way is that I did not want to add muxing code to *all* drivers. I.e. it
would not be flexible to have to add boilerplate mux code to each and
every IIO driver that happen to be connected in a way that a mux has to
be in a certain state for the signal to reach the ADC (or whatever).
Instead, new IIO channels are created for the appropriate mux states
and the IIO mux is connected to the parent IIO channel. When one of the
muxed channels is accessed the mux is selected as needed, and the ADC
driver needs to know nothing about it. If two muxes need to be in a
certain position, you again have no need to "pollute" drivers with
double builerplate mux code. Instead, you simply add two levels of
muxing to the muxed IIO channel.

I think the same is probably true in this case too, and that it would
perhaps be better to create a mux application for phys? But I don't know
what the phy structure looks like, so I'm not in a position to say for
sure if this model fits. But I imagine that phys have providers and
consumers and that a mux can be jammed in there in some way and
intercept some api such that the needed mux state can be selected when
needed.

Cheers,
Peter

> 
>>> +		if (ret) {
>>> +			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
>>> +			return ret;
>>> +		}
>>> +	}
>>>  	if (can_transceiver_phy->standby_gpio)
>>>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
>>>  	if (can_transceiver_phy->enable_gpio)
>>> @@ -45,6 +55,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
>>>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
>>>  	if (can_transceiver_phy->enable_gpio)
>>>  		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
>>> +	if (can_transceiver_phy->mux_ctrl)
>>> +		mux_control_deselect(can_transceiver_phy->mux_ctrl);
>>>  
>>>  	return 0;
>>>  }
>>> @@ -95,6 +107,15 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>>>  	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>>>  	drvdata = match->data;
>>>  
>>> +	if (of_property_read_bool(dev->of_node, "mux-controls")) {
>>
>> Is this the proper way of doing this? Looks like we need a
>> devm_mux_control_get_optional(), which doesn't return a -ENODEV if the
>> device doesn't exist.
>>
>> Cc'ed Peter Rosin.
>>
>>> +		struct mux_control *control;
>>> +
>>> +		control = devm_mux_control_get(dev, NULL);
>>> +		if (IS_ERR(control))
>>> +			return PTR_ERR(control);
>>
>> What about making use of dev_err_probe()?
>>
> 
> Sure, I will make this change.
> 
> Thank you for the comments.
> 
> Regards,
> Aswath
> 
>>> +		can_transceiver_phy->mux_ctrl = control;
>>> +	}
>>> +
>>>  	phy = devm_phy_create(dev, dev->of_node,
>>>  			      &can_transceiver_phy_ops);
>>>  	if (IS_ERR(phy)) {
>>> -- 
>>> 2.17.1
>>>
>>>
>>
>> Regards,
>> Marc
>>
> 
