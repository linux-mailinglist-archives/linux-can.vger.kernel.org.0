Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F9145DBFF
	for <lists+linux-can@lfdr.de>; Thu, 25 Nov 2021 15:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354834AbhKYOMj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Nov 2021 09:12:39 -0500
Received: from mail-eopbgr60129.outbound.protection.outlook.com ([40.107.6.129]:31237
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350362AbhKYOKi (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 25 Nov 2021 09:10:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VD1HPPrHgzF0gJrDyqXEQHzpBde58WFltUUUb0BxvHHLR809+D3rFnoni/WNjNzsiDVHuzCziyN+PpLgJvVTOJkbwc9y486s1sIBDtK4vk28NkML+IHFmPkmDir7jXhQglIPORH/8tLKgrALBdXZKg7rHFf3WN1M3oi+E0h2yc0pjU4hNFlRTqentLdcLyA89WFGRiVOYuNvbApD4zGceoYbVCwAl7FhahK3jXId0VsXK15oB7DBW6IPA85v8rUiSmJiIDsB8RUFAXTeIfhwYMaPkqx/4G2hs9vnppBtIK172mOJOc5dYab16gIaQ0NSG5RX4VyiDWX3rj5Z57s5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdUj6DxSTarx5xrCjuoHe2Cx31QG+h+fAme1K/+ElPw=;
 b=ZcrTM9tHfMRFpDcAP8sav0o1TuhGH9TlDy2I/YLL6ZGTJRslHflBPf5N8qZcAkQ392MqtQMR/d6Ml/1dOHeEaQ3099ExJ3EHTwv/v8jZVxp3BXRZdwRpdOEBwMQ7G6Tpc3DMg5aRmzsJ6j15XO16WkaqqjLVLo64GZE9Xn0OT8iT6PbXkuf0HnIQSJEcesU4yVJrGJelezEviYNb9SMJuJrUL03mC+NaK/kRzmOkUwd3JEW5oiZaVcSbVixBxCMHuU/OxzfRCiK3QBt8Fjeouobhyw/yaxwuMEvyhE6c1NmmPEIr4kWJ43eGyb0N+iXKciTGFEPRISHOJpxXIts2Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdUj6DxSTarx5xrCjuoHe2Cx31QG+h+fAme1K/+ElPw=;
 b=H/mcEQgO8tCqRJ7hFUU1H3EPx9bXxoA1sEqLI9iZZKOq1zFc+/AULt0RooNSq2cJflw2zfvRwmTPr4gtbjCB2mQM90RZMPPB3Izdunp9CSsB2buMMFQ1kPU49+m+rTQPA1WRNC6nMnlSkO4DC31AZHgxVVnoAWeYlFEzyAnstlA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB7PR02MB4475.eurprd02.prod.outlook.com (2603:10a6:10:68::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Thu, 25 Nov
 2021 14:07:25 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 14:07:25 +0000
Message-ID: <a1d9d0c6-e0df-2e06-d8e8-8770a9eb4b4a@axentia.se>
Date:   Thu, 25 Nov 2021 15:07:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v3 4/4] phy: phy-can-transceiver: Add support for
 setting mux
Content-Language: sv-SE
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20211123081222.27979-1-a-govindraju@ti.com>
 <20211123081222.27979-5-a-govindraju@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211123081222.27979-5-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0043.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::7)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0043.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Thu, 25 Nov 2021 14:07:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01d79ece-7c37-4a44-a5cb-08d9b01ce820
X-MS-TrafficTypeDiagnostic: DB7PR02MB4475:
X-Microsoft-Antispam-PRVS: <DB7PR02MB44752299CFFB6718CF733213BC629@DB7PR02MB4475.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AGfWycsL+w5DDiHtLrS9TzsJq/zPt76wREIQlTkWZwlETdJ1gQKu8/NSXBTuFjfeIE4DKiJB72iOx4z+tZYVBU0O+KUhRIPteEqlBO/vu2Mt4GBkCBo46K/BhU1Jr8pJyjzz1ZajixmEU2e0ComnpwV3U36HbkEL4fcao64t5CD5Jkt9Pmo0M3fCPqtUrVZ71FNq3BrYvGuxYOdCSrE6M5s0njnwgUlyMgEFwyQXRqqPScyyUBS/ka+7NaAWjuRX85xwhqZkp6v3pMVH6iDfU6l/jVvrNltyyD7uPJUBw1oF7eokadXImDNiApkLqGJuwbmmKulRpkgh0ONz0mnU6gBpwqbKhIFphIpGGEMhCgQt+FcU1TOrRSXN8NDJrnL892qO+PeagJSpCcWSoX6V3V3zOfxf+NiQTg7CkYcarfBgUmieKRELBLqHBrJCzMWeEKKC+dyjH50Cnu9bceyn2xx6ALvW37zZyDk0QR/WAA2W8UVTh3W6cL22AuhhVwIi+6rJPF9/6CjAfTA0u3nZy4Bxtk9FGXVYo5uBmuGehm0/78iOet+TVL4f2PhOX2NfeIJXUH7xOXQ/MnQ7Ep5TtIFrZL0TYmcwU10Bk/z1OEGfqiG/HAXNOcvIjX2rK3fQbvY3yk3inFXnrx4YmAx/OvGABI4yxs5PS9YtyO4q266XMSR+nHi5EOhb2PUki9RWz4c0nq2qr2qnazlNLuGvHpp/cEQl/jXBnb+vBfxn/ulpOGwLjAJ7N/jMOW74F3Wt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39830400003)(396003)(376002)(366004)(346002)(956004)(8676002)(6486002)(38100700002)(26005)(186003)(6916009)(508600001)(8936002)(4326008)(2616005)(31696002)(16576012)(54906003)(66556008)(66476007)(316002)(86362001)(66946007)(83380400001)(2906002)(53546011)(5660300002)(36916002)(4001150100001)(36756003)(31686004)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXFjd2YvU1ZxcFd1N0xxMXlRc0YzSDlFUXVxNGQ2eXNCSEVySG9PSHA2UkMr?=
 =?utf-8?B?QlV1eXB5aVdRQmhoRHNJRTM5eTkzNWZaY21YeXVvaEVKeUtCZUdERVFrM3Bp?=
 =?utf-8?B?Zy91QXQzcmExM0ttcnQ1cllFM3JqN2JsMFpzeVYzOURHS0ZMMmM3bkZLQTJS?=
 =?utf-8?B?LzB1VWJ6b0NrNnI1R2Z3UStVUERYd09QQVZrK2RsNDJuWEtEYW15cnRwZmdw?=
 =?utf-8?B?UHNFK0hLM0FzTUtBOWtjS1VLSSs4RElwTFRFalFUcnhXSE1NRkdiQk1kbGNs?=
 =?utf-8?B?S25ETDU4SE9ycTZ5cTlhZVM5TU1ndjd2WmNDbWU2UHU5a0U0QTBRNjBvSEE5?=
 =?utf-8?B?YUxmeTFUTktlRExxQ3RPZmhtV0pXVXphWU54aWdBYVNWYjF1bUhTTWZWZ0ZN?=
 =?utf-8?B?d29vZEQ1WDlHK3VSYXgvcDB0Z1FuRG04T2tHaUl2N3pSMFVPN0xKL0ZEdzBJ?=
 =?utf-8?B?OVMyVHRRTm9oRDN0M3lKNEVUZEMxdkdvckhzRzFZckpMSWw3VENpMzRqdmg1?=
 =?utf-8?B?MEtzdmpxMlJIM2g0TjdveWdQZTFqZWlUK3R5V0xjUHRLeENGNTRXTTdoL1dK?=
 =?utf-8?B?TnJJS3ZISXQvcGJwVllEWXZ4cGpWc1JydU8zL1lhZkd4bzdXUUVIZSthR005?=
 =?utf-8?B?YmNSM3RSOTI2SU10OTlpS001Z2x5WXEydVZ4OUw5Wk1GVXQ0N1NyV2hYRDR2?=
 =?utf-8?B?MllUdmUwK2R1ZDZpUmJRVVZnQXhRS2o2WGZBZG9NUkUrS0FXVTRFdkljT3g2?=
 =?utf-8?B?dUNma2pkZG40eHU0V3VyQUNKT2lsWTlhRkRadGhpQjRtUHhxVzZjUitkSkJ6?=
 =?utf-8?B?cG5XWGNtdG9lR0ZPRmV3NHZCajBLWkpXVVd2VXdieC9LL2RWbU9NZ05MenBj?=
 =?utf-8?B?dW9ONVZGNWVUekJ4aE9WU0dQUzMrUUEycFNnNzJHVFc1dHR6UWQrNEdpN0Y0?=
 =?utf-8?B?Wll5UmY0Y0duNWp1L2k4amlQTkJZRCtab1cxTU50MVhPS0JJaDhmVk9iQ1Zh?=
 =?utf-8?B?RHVCeml2aUkyckJMZ052Zi9FUk1kWUdiU3lmVmVHdGNiMWNxcGdrNy9tNnMx?=
 =?utf-8?B?dnAwQWZ5T1dqWXp4SkZFNitueENNSnNFazVkT2ZtVUVNbDNZSDJpZ3VuZHdr?=
 =?utf-8?B?K1hlay9wWWQyT2MrSWR6ZW1UR3VnbTJ2c2Y3TjFhOWVVV0IzZmY2VjZnMVF6?=
 =?utf-8?B?Vjd5VzBJRHR4ZjdHYXRSVWdVVWhFdXV6YUZsRGlsQ1RFVms1UlRFbFpWa1Jp?=
 =?utf-8?B?UUp2clUyWldud2xveUQ2eHY2M1pJMWVydmpWSmtOV3NCcWp2RnVwaHQ1UTda?=
 =?utf-8?B?b3c0THNtSE92UDRJQnVUZ3d6T3B0ZXV5YnZhc1lqWlFpTEh3RjZPWE85V2Ir?=
 =?utf-8?B?Yk5lOGJYZ1ZINnR3MEp6dm9iVnp1WVYxaFY1V3NVdit5S2gxbUNwbDUwT21p?=
 =?utf-8?B?RS95UU1oUU5SdTNCcGhCcW93MUVTKzVLdENIY2lhcS9POUlvS1NMemwxK2dT?=
 =?utf-8?B?TTU5bnVVbDVZcEVWVy9YTDFrQll1YTZoL0RZblpwUnJkaEVoUmFjNktQVUJ2?=
 =?utf-8?B?RVVjd1k5TUhaK0V6VG9DbHoxc3ZReTBML0ZFRGV1ZTRmN2RqZXdzeVZ2MS9C?=
 =?utf-8?B?aTl1dFdZQndoeEl3RVpKUlRpeDhFYVZmZTJmajhwSzU5RnMvLzU4OHF6Nk9m?=
 =?utf-8?B?cTVLM005amw1TkdtSVIzcSszUWhOcW1hZ2dtMTBnOXBIQW52c0VXRjJWMTBL?=
 =?utf-8?B?VVdOK0JnWlZ1VUVFc3Z1dWJYbk5teDd1T0U2eExvdzByOXNYYkYrQ1Y2T0tu?=
 =?utf-8?B?OHF2Vkx0SlZVaDlZeEh4TS80ei82VGFZUjNrbFcxaFN0V2tlRGQxcGZ1NEN4?=
 =?utf-8?B?NlZHOGZZUUNxT3kvYXRjeWNUMnZSMGZITTlBVVpTNHorb0o1QkdrVGRmbjB6?=
 =?utf-8?B?WE9jYVRlT3VEa3VxUU90RzkwV1E2M2NHVkxRMDcvaXFWSENLZUFoV3V0aDBS?=
 =?utf-8?B?a1RvTTZ4djducEpiRlNqbjkyWFRCV0dYVVU3UGM3NWhpcS9YYTdVUDExSU5B?=
 =?utf-8?B?dzBiN0NtZXhGSFd1R3VqWkhhb2RPZmZ6WFZ5S0dRUzB3VlVnNUJEWXJtcW80?=
 =?utf-8?Q?SbaA=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d79ece-7c37-4a44-a5cb-08d9b01ce820
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 14:07:25.1181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5enS8dUIvi7P6oHg1C6PbJA3vBOlJkIf35alPlymiNW2M+qDNqD1h3TyF07EC29L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4475
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!

On 2021-11-23 09:12, Aswath Govindraju wrote:
> On some boards, for routing CAN signals from controller to transceiver,
> muxes might need to be set. Therefore, add support for setting the mux by
> reading the mux-controls property from the device tree node.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/phy/Kconfig               |  1 +
>  drivers/phy/phy-can-transceiver.c | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 82b63e60c5a2..300b0f2b5f84 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -64,6 +64,7 @@ config USB_LGM_PHY
>  config PHY_CAN_TRANSCEIVER
>  	tristate "CAN transceiver PHY"
>  	select GENERIC_PHY
> +	select MULTIPLEXER
>  	help
>  	  This option enables support for CAN transceivers as a PHY. This
>  	  driver provides function for putting the transceivers in various
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index 6f3fe37dee0e..6c94e3846410 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -10,6 +10,7 @@
>  #include<linux/module.h>
>  #include<linux/gpio.h>
>  #include<linux/gpio/consumer.h>
> +#include <linux/mux/consumer.h>
>  
>  struct can_transceiver_data {
>  	u32 flags;
> @@ -21,13 +22,22 @@ struct can_transceiver_phy {
>  	struct phy *generic_phy;
>  	struct gpio_desc *standby_gpio;
>  	struct gpio_desc *enable_gpio;
> +	struct mux_state *mux_state;
>  };
>  
>  /* Power on function */
>  static int can_transceiver_phy_power_on(struct phy *phy)
>  {
> +	int ret;
>  	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
>  
> +	if (can_transceiver_phy->mux_state) {
> +		ret = mux_state_select(can_transceiver_phy->mux_state);
> +		if (ret) {
> +			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
> +			return ret;
> +		}
> +	}
>  	if (can_transceiver_phy->standby_gpio)
>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
>  	if (can_transceiver_phy->enable_gpio)
> @@ -45,6 +55,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
>  		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
>  	if (can_transceiver_phy->enable_gpio)
>  		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
> +	if (can_transceiver_phy->mux_state)
> +		mux_state_deselect(can_transceiver_phy->mux_state);

Careful, it is not obvious that you are following the documentation you
added in patch 3/4

+ * Therefore, make sure to call mux_state_deselect() when the operation is
+ * complete and the mux-control is free for others to use, but do not call
+ * mux_state_deselect() if mux_state_select() fails.

Or, are you absolutely certain that can_transceiver_phy_power_off cannot,
in any curcumstance, be called without a successful previous call to can_transceiver_phy_power_on? Or that can_transceiver_phy_power_on will
never ever be called again without a can_transceiver_phy_power_off in
between the two on calls?

If there is any doubt, you need to remember if you have selected/deselected
the mux. Maybe this should be remebered inside struct mux_state so that it
is always safe to call mux_state_select/mux_state_deselect? That's one way
to solve this difficulty.

But then again, the phy layer might ensure that extra precaution is not
needed. But it might also be that it for sure is intended that this is solved
in the phy layer, but that callbacks (or whatever) has been added "after the
fact" and that an extra "on" or "off" has just been just shrugged at.

Cheers,
Peter

>  
>  	return 0;
>  }
> @@ -95,6 +107,16 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
>  	drvdata = match->data;
>  
> +	if (of_property_read_bool(dev->of_node, "mux-controls")) {
> +		struct mux_state *mux_state;
> +
> +		mux_state = devm_mux_state_get(dev, NULL);
> +		if (IS_ERR(mux_state))
> +			return dev_err_probe(&pdev->dev, PTR_ERR(mux_state),
> +					     "failed to get mux\n");
> +		can_transceiver_phy->mux_state = mux_state;
> +	}
> +
>  	phy = devm_phy_create(dev, dev->of_node,
>  			      &can_transceiver_phy_ops);
>  	if (IS_ERR(phy)) {
> 
