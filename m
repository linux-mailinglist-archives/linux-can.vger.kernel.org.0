Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A355D459537
	for <lists+linux-can@lfdr.de>; Mon, 22 Nov 2021 20:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbhKVTDE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 22 Nov 2021 14:03:04 -0500
Received: from mail-eopbgr70120.outbound.protection.outlook.com ([40.107.7.120]:32334
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230159AbhKVTDC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 22 Nov 2021 14:03:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dt3v9rIskasUqaGI1KMzES8R/1qUv6WypQvyE2cPaFj/8tGf2YbaaL3xDfSQUgHdQW+qXTxy2CXUbr8EyVROY4ov2kxJFtVtQt8eCTbelGT2DC9eaYi9sNA8Wo8MsE1tqxMZWrTw2U5CFq0WzDy+bkZ/bvPCB3JYWf/DDWbFxUOam0YmG2JbumgqkCKxZhJT5msGOjBVmE6bcHP0ylGwb/2+XefDOvpz5yu1R8iCWC6h59y3wX6lbsjxI/GlHlSY4ZnVAcvoY7nWO+BaVdKQSkw2RT9Jnv48nirJ8bQOPs/8/oofwA5dGnACdzcsiwEjPznhf1IFn02Tdvh4A+Hxag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBanGxPDxJF75Dt7rFZ/YICjdn98tXLubcOrlJXxzOs=;
 b=OQ/V3HD0BX5oDwpkFn15ublFfeOkShIATrNgN56J1isUt+0PwvXUVAr/usAl+AAx+EhOJxHIzavzqfvuqQKA9w9Z73cK5YcYKsYleoHu8Tx1j1+HNCyHpkqU88nlDsf2KWvLd0EF2Eq+J7pKKgHl+YyqMmB5gK9tQu5mnK7coeR9A/wepPjyNU80/WTdTcos2wWQyMzw4YZIgPN0jzm7zmxV3D/cRVEn72qhEh1BIAxD/QiBp0Ae5ngVj3GeeskUbEBw/ipM1Ui3tjfKQDz1HcGETkwnYdipDKmuidGWJevz93qkaRllg4V+iW7CLLxjmFeqOq/U6AO7lfFsKK+2Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBanGxPDxJF75Dt7rFZ/YICjdn98tXLubcOrlJXxzOs=;
 b=NKtJfDp3wdyOt10JpvImizBciTyzCKflhwz/evkPXsk5Fb3atnVFHRaN48c6xd43v6kPuwpkx9W9GG+0RYCrafa5mRJ0zt9b8AgyaaujdqC1GwJ4BabPdvY7YpdUCHe7srHhX+r4UrjBuyp17mIKvlf9DLz4Xo8vrM1IR6Xmwbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB9PR02MB7051.eurprd02.prod.outlook.com (2603:10a6:10:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Mon, 22 Nov
 2021 18:59:52 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4713.024; Mon, 22 Nov 2021
 18:59:52 +0000
Message-ID: <69f73f64-6424-4e3f-9068-195e959b9762@axentia.se>
Date:   Mon, 22 Nov 2021 19:59:48 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v2 3/4] mux: Add support for reading mux enable state
 from DT
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-can@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20211122125624.6431-1-a-govindraju@ti.com>
 <20211122125624.6431-4-a-govindraju@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211122125624.6431-4-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0033.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::26) To DB8PR02MB5482.eurprd02.prod.outlook.com
 (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0033.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Mon, 22 Nov 2021 18:59:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a896df19-2fd7-40ae-8d5d-08d9adea43fe
X-MS-TrafficTypeDiagnostic: DB9PR02MB7051:
X-Microsoft-Antispam-PRVS: <DB9PR02MB705105C2908FB86B8C53F439BC9F9@DB9PR02MB7051.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pktnjQ8ddvUMlKtVFkic4gSVWrSLhP9tId+2dPjCMG14eW4YVqzamuRuP70TXEj1X+DkrC499/R2sd76F5WpebrJ+ChZUx7tAdT3f3ziSiQB+hpzYIM+FzfS3scRR4VMFnWnvrWMSxR3j7Zkgg9D4Z46AjcIivbPE2PnF83RFhuoljIZ9M4tuJyGD94F0lMVfx3cP/tkrxdBe1BLhYgdaeSU5sZ9Zruxg1ewpFxUYntDoYeA1hccajAhCBOkNdQmlUxZWLDb8VcJgWKvypTM0j0dCJ23xgL4NCACm/RDzjp7xYpjpFmblLmNz02/ARD1dwmYRCCLdklxqS54jrKL6K+tXdzqlLjHVxxWdFMdEdDcZQG3oH0D3kvdLLgwzDrRJOp157idjqJg102gLhCTUWVqyzGHVP9DWnspPqX42Dz5PV172aKhSSCMPTBAgGQ53bBFowtOUl89Z78FeuCZ70SCN8Qwrk4Zu5bqtSKNBX21JXo+TC4cqnHS7DhXZ5rV7bcK/upLcusOQz3wv4U7McLmV/8/6VxWDYeEhJjhiB0aEA7OK+nzHw//Fx5ayY88neiYf0ywfSDwoTWddg8PhXqv4jkTe3JZOBTrlAPcZH9wuVtogWL0G6Dr1w00+f56Ak4EhZ0jr4/Ck7qB7GV/8DWkGZaPpDOYBDw1y5RaAp4u5F9g9d/7m/ynl3lc1F1ZRUOEZaBt4dPgF4jefTVuSIXyIzZJF0tu8ubbRB5U4A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(39840400004)(376002)(36756003)(7416002)(956004)(66476007)(2616005)(2906002)(508600001)(38100700002)(66946007)(36916002)(26005)(5660300002)(53546011)(31686004)(6486002)(66556008)(186003)(6916009)(31696002)(16576012)(8936002)(54906003)(83380400001)(8676002)(316002)(4001150100001)(4326008)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjlJdDk4YytNQ1llODltVlFKM0N5dXUvcnhYclVBamI3d2NkSVJ5Z1AwWVdU?=
 =?utf-8?B?cXhZcFB6dVhwOGI0dW14KzRib3pyUUUvcW1JRitrbWJGY1hkZ05yNHUrQjN5?=
 =?utf-8?B?Mk04NXF1SWt2aWlIT1RJV3NrY2Rmb28xbDFVTWZLZ3dHbndLOTNCYThSK24y?=
 =?utf-8?B?bTFSYzd5TEQ1ek0wdERzQ2xVL2VVQzJNMGZINVdscFJnOWZsb1hyWGdMYk5h?=
 =?utf-8?B?NzltdlBOZGFXTFFKN09jWHEyUTRSU295eWxXR2RFSGJxOThJeDRlVUc0R2dr?=
 =?utf-8?B?TlUwU05ISjJZaktsVXo5UWI5Y1VybGREOEJCeHpFRHIycGQ5djNieC9nYlpH?=
 =?utf-8?B?SGxLcWcyQ0FESk8ybW14clJ5Rm83ZEFXcUhNL0Z4SXptRi9sU05vN0YxN1B0?=
 =?utf-8?B?N21LZXZpUzlTQkNEOTNFZ255YmdqVVVpcmN1OHFKaTRLZ1hwdjdjRVExOURX?=
 =?utf-8?B?cVBaRFJDU1JkaUNHdnNPUnVTSm5BZFRSZkR5YnBmd09LeS9MUk9LWEJOR0Vj?=
 =?utf-8?B?OHVjU1k2bnN2VExLcm9TVXFyWkZ3T3RQTzNtblhFK0F4OTE2RFpOblY4blVR?=
 =?utf-8?B?ZURxdUh0RTllN1BtYzlTbFQzcmVqcG5xM3FkQTZtTUsxMHVCbU5wYjlFZyt0?=
 =?utf-8?B?OFRDNXI3bnQ4Zjh3enJjK1RKa0FUQ2ZXMURheTdWbURxaHUrYTliMHZjbFFt?=
 =?utf-8?B?SVRQY2x3elRIRjA5b2ZEdGFZYlc0QzlUUUZyQVExcVNrWTgyMXFOZW5abGdD?=
 =?utf-8?B?ckRoSmVYZFhQNExtM3ArVyt3ZTd4aVlwbnZLR2l4QnFBL0JWRUo0ak1GalE4?=
 =?utf-8?B?alRDa290bzg1MmdlN2tTd0xweHlKRGFJemJ0NDNzOG5NMEw5REc4RDNxZTNW?=
 =?utf-8?B?QzNWai9MYUJLWXZMSHFvU2VsL2FTMGtMQ1ZkWEhuNWhkekhqTkNNdUc4OE5N?=
 =?utf-8?B?V1ZoNHpOdkYxQ3NQeUcxTEhubkFuVEdVZktlVnNSTStqZ1Y5WW1oclU2ejVN?=
 =?utf-8?B?bTR4UHVpa3J5dlFqVitEeXhIWW5YUTBnWEdjVzhnVlFxOERuV2djTDJEQXNW?=
 =?utf-8?B?dTQvRmJXbnJPOUNERG1hYXpjUkJobWQ1cEYxVU5HZjJUM0NJRG9KOENPbEpJ?=
 =?utf-8?B?TTJMR29aQ3RFVVk0Nmw4U2VVaFFwazZhK3kwMVBSclV4K3ZqZk5FKzVRYU5I?=
 =?utf-8?B?TFFDT1lldmIvaVZIUVdQeloxOWROeTQzcW9ZMzdTckFqRFJiNUJqTFJFNUhr?=
 =?utf-8?B?aWJkeE5qSXdzQ1hydGpUK3FPYmJEK0VBa244SGhrNVlBU1E5amlrTjg1MFIx?=
 =?utf-8?B?dzJmREt4TjF4TkFTK3IrRUY1ZnI1aE0wSW9xKzJ0bVpBaXlFcThaemV6TS9F?=
 =?utf-8?B?bm1DcGJ4a0RDQm5Id0dOcFV5RXdFbGhpeU4weE16YzlWbkY2MDNtTnNaeGRC?=
 =?utf-8?B?bnk2NXp2WVpRSjNhZlBYeXpqdUU5U0syN2x3ZHNneG14bUdVVHl3WUs5dFdJ?=
 =?utf-8?B?Wk4xK0p6MVdxRUZtTEp1ellEL2orNDBHYThodXVTZFNpbnZXVFBWNzc2VFJh?=
 =?utf-8?B?LzdtMjVybXpyN1M3dE9GbTlkelphN0JyMjNTOGtyMEhGNzlZR28ySFo2RDNT?=
 =?utf-8?B?aU05bm1pNnZkNnBxMmZBVXhFcmdzY0ZaZy96SUx5WjY1TWdGdVhrN25pSW5y?=
 =?utf-8?B?cW8xU3o5dTgxU05oYlBqdWVlTjJuTUNWbHNWWjBTL0lVV2lJZlh4UEF0MFZI?=
 =?utf-8?B?Y1VLNHl6MnBlVDVKeEo1L2JIZ3FEL0lWR1JQeEYyNXA4WnA1OTRDYmpkbEJw?=
 =?utf-8?B?bGZWeERnUW9DckxuTUNUaDl6WFo3a211NTJEdHBtVHQyUEZEV1JzcWdzNmJQ?=
 =?utf-8?B?cy9TQUhkVHNVVTRKNjJkbHdpbHpmdkxBVjJkd2VMZUprci9ieWs1NG80S29l?=
 =?utf-8?B?ZGFzZ2RRb0I3T2hNMHM0c25qTnU1cmR0QkV3b3p4S0lvYWQ4T2dUTWNIeU5l?=
 =?utf-8?B?SkhWQW0wb25zNmZLOVhIbkRDLzI2U0lxZHJEWVVRbGQ3TWUreEdhVGcwa3BX?=
 =?utf-8?B?UEJ4UEJXR1JGM01BMG1zclo4RDNpRUUvSS9EUVRIZExQZnc2STdKVm9NZ2dQ?=
 =?utf-8?Q?P9Qc=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: a896df19-2fd7-40ae-8d5d-08d9adea43fe
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2021 18:59:52.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r33A8LlhO8C0DmlEDCFSQEzyo+9Lf/E8hUa1tgQ5NyyZ3kvAJealLPPsUg955zs3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7051
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!

On 2021-11-22 13:56, Aswath Govindraju wrote:
> In some cases, we might need to provide the state of the mux to be set for
> the operation of a given peripheral. Therefore, pass this information using
> the second argument of the mux-controls property.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Notes:
> - The function mux_control_get() always return the mux_control for a single
>   line. So, control for mutiple lines cannot be represented in the
>   mux-controls property.
> - For representing multiple lines of control, multiple entries need to be
>   used along with mux-names for reading them.
> - If a device uses both the states of the mux line then #mux-control-cells
>   can be set to 1 and enable_state will not be set in this case.
> 
>  drivers/mux/core.c           | 20 ++++++++++++++++++--
>  include/linux/mux/consumer.h |  1 +
>  include/linux/mux/driver.h   |  1 +
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 22f4709768d1..51140748d2d6 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -294,6 +294,18 @@ unsigned int mux_control_states(struct mux_control *mux)
>  }
>  EXPORT_SYMBOL_GPL(mux_control_states);
>  
> +/**
> + * mux_control_enable_state() - Query for the enable state.
> + * @mux: The mux-control to query.
> + *
> + * Return: State to be set in the mux to enable a given device
> + */
> +unsigned int mux_control_enable_state(struct mux_control *mux)
> +{
> +	return mux->enable_state;
> +}
> +EXPORT_SYMBOL_GPL(mux_control_enable_state);
> +
>  /*
>   * The mux->lock must be down when calling this function.
>   */
> @@ -481,8 +493,7 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  	if (!mux_chip)
>  		return ERR_PTR(-EPROBE_DEFER);
>  
> -	if (args.args_count > 1 ||
> -	    (!args.args_count && (mux_chip->controllers > 1))) {
> +	if (!args.args_count && mux_chip->controllers > 1) {
>  		dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
>  			np, args.np);
>  		put_device(&mux_chip->dev);
> @@ -500,6 +511,11 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	if (args.args_count == 2) {
> +		mux_chip->mux[controller].enable_state = args.args[1];
> +		mux_chip->mux[controller].idle_state = !args.args[1];

Please leave the idle state alone. The idle state is a property of
the mux-control itself, and not the business of any particular
consumer. Consumers can only say what state the mux control should
have when they have selected the mux-control, and have no say about
what state the mux-control has when they do not have it selected.
There is no conflict with having the same idle state as the state the
mux would normally have. That could even be seen as an optimization,
since then there might be no need to operate the mux for most
accesses.

> +	}
> +
>  	return &mux_chip->mux[controller];
>  }
>  EXPORT_SYMBOL_GPL(mux_control_get);
> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
> index 7a09b040ac39..cb861eab8aad 100644
> --- a/include/linux/mux/consumer.h
> +++ b/include/linux/mux/consumer.h
> @@ -16,6 +16,7 @@ struct device;
>  struct mux_control;
>  
>  unsigned int mux_control_states(struct mux_control *mux);
> +unsigned int mux_control_enable_state(struct mux_control *mux);
>  int __must_check mux_control_select_delay(struct mux_control *mux,
>  					  unsigned int state,
>  					  unsigned int delay_us);
> diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
> index 18824064f8c0..7db378dabdb2 100644
> --- a/include/linux/mux/driver.h
> +++ b/include/linux/mux/driver.h
> @@ -48,6 +48,7 @@ struct mux_control {
>  	int cached_state;
>  
>  	unsigned int states;
> +	unsigned int enable_state;

This is the wrong place to store the state you need. The mux_control
is a shared resource and can have many consumers. Storing the needed
value for exactly one consumer in the mux control is therefore
broken. It would get overwritten when consumer #2 (and 3 etc etc)
wants to use some other state from the same shared mux control.

Doing this properly means that you need a new struct tying together
a mux-control and a state. With an API looking something like this:

struct mux_state {
	struct mux_control *mux;
	unsigned int state;
};

struct mux_state *mux_state_get(struct device *dev, const char *mux_name)
{
	struct mux_state *mux_state = kzalloc(sizeof(*mux_state), GFP_KERNEL);

	if (!mux_state)
		return ERR_PTR(-ENOMEM);

	mux_state->mux = ...; /* mux_control_get(...) perhaps? */
	/* error checking and recovery, etc etc etc */
	mux_state->state = ...;

	return mux_state;
}

void mux_state_put(struct mux_state *mux_state)
{
	mux_control_put(mux_state->mux);
	free(mux_state);
}

int mux_state_select_delay(struct mux_state *mux_state,
 			   unsigned int delay_us)
{
	return mux_control_select_delay(mux_state->mux, mux_state->state,
					delay_us);
}

int mux_state_select(struct mux_state *mux_state)
{
	return mux_state_select_delay(mux_state, 0);
}

int mux_state_try_select_delay(struct mux_state *mux_state)
			       unsigned int delay_us);
{
	return mux_control_try_select_delay(mux_state->mux, mux_state->state,
					    delay_us);
}

int mux_state_try_select(struct mux_state *mux_state)
{
	return mux_state_try_select_delay(mux_state, 0);
}

int mux_state_deselect(struct mux_control *mux)
{
	return mux_control_deselect(mux_state->mux);
}

(written directly in the mail client, never compiled, here be dragons)

mux_state_get is obviously the difficult function to write, and
the above call to mux_control_get is not appropriate as-is. I
think mux_control_get perhaps needs to be refactored into a
flexible helper that takes a couple of extra arguments that
indicate if you want an optional get and/or a particular state.
And then mux_control_get can just be a wrapper around that helper.
Adding mux_control_get_optional would be a matter of adding a new
wrapper. And the mux_state->mux assignment above would need yet
another wrapper for the flexible helper, one that also make the
flexible helper return the requested state from the mux-control
property.

I realize that this might be a big piece to chew, but you want to
do something new here, and I think it is best to do it right from
the start instead of having weird code that only makes it harder
to do it right later. Ad it's not that complicated.

Cheers,
Peter

>  	int idle_state;
>  
>  	ktime_t last_change;
> 
