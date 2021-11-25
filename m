Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5C45DBB5
	for <lists+linux-can@lfdr.de>; Thu, 25 Nov 2021 14:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351766AbhKYN5W (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Nov 2021 08:57:22 -0500
Received: from mail-eopbgr40099.outbound.protection.outlook.com ([40.107.4.99]:47413
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1355407AbhKYNzV (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 25 Nov 2021 08:55:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4uGZKfjXiU+m7/0q+Fy3jrIxRTt2W0qnMDs0QyeuQhPTgZcwdLjo9vXWMgIasaSE6f3NKEuj+VK9V+yt4Ir2/mb2jW9RpLcV/sW9FAJUmVjSCaRZU/T9kDVWgqNhjGVL6plOBYkkOpg9j5ildtp+tjrFCSmduIvrcjp+EOYUvOsaGFqRa6/wpzsFkFbGUYS98QOkpfq9cy3rHpdTWj7Lml0wH3b72kFxBdac2g9/5O29Hbsyi+7bXXY5IK4hd41psqHYx+aLqIXewfv/LZ2o6BuI8+MAZMb9Oc+m083ymoC/GoVk9HFL7aMeReYQ+rfUg0W/NHMoHxikLGaAoU+vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTaNiTNICT4V48/a7W8G1l3Ub5UpC0xxy+3nSuaWsmE=;
 b=nDsB5KfXKaNOs8EADQk9uaRvXZDKXaLq97HAlZkftChpuUFj1vFtcihdpDG6WvNH83BSYnezg2ES7f591emMYqNCnWIWMawOj4OmP11XBOtayixxglEtegNXwPupj7Zle0gCU4ngXNvH+HEagoU80sjCappP8LIYBccJCzAjQW+KwDP0yLSSPNRVXtXvWosJGws/4f0gNw0pJFu6KsE/9rUQw1NYcwZPLX88vC/vNDdLc8tAHkCtbTu5J69DY7k5Zz0b7Qksj+d38ZBVH7NdCO/PvqFpZkDPIEHa3dv0vxmsj9nV2usKN+wORVsUBjEjfV/B77CkdWpV2SmRSBtXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTaNiTNICT4V48/a7W8G1l3Ub5UpC0xxy+3nSuaWsmE=;
 b=ZxEFlNqxgG6rMxW0Ci7SCZKT/VsmX+LExBLyooQEyfiy72/n7k2jcoCfqxhjeFWsd266BOXZrv2lnnBITu4pMrQFl86fuO0192eyZ8RANBVEv9+SIynTnKcW6bg7t/9ZgRsN+IrsmfnPbza0n3UZwk5ZQk/BV7TW683lxHOopHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
 by DB3PR0202MB3402.eurprd02.prod.outlook.com (2603:10a6:8:6::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Thu, 25 Nov
 2021 13:52:07 +0000
Received: from DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39]) by DB8PR02MB5482.eurprd02.prod.outlook.com
 ([fe80::7519:c72c:98b1:a39%4]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 13:52:07 +0000
Message-ID: <5a530528-27a9-f5c8-abd4-025897a1c197@axentia.se>
Date:   Thu, 25 Nov 2021 14:52:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v3 3/4] mux: Add support for reading mux enable state
 from DT
Content-Language: en-US
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
 <20211123081222.27979-4-a-govindraju@ti.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
In-Reply-To: <20211123081222.27979-4-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0043.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::7)
 To DB8PR02MB5482.eurprd02.prod.outlook.com (2603:10a6:10:eb::29)
MIME-Version: 1.0
Received: from [192.168.13.3] (185.178.140.238) by GV3P280CA0043.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:9::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Thu, 25 Nov 2021 13:52:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75c251f5-3e7c-4781-bfec-08d9b01ac555
X-MS-TrafficTypeDiagnostic: DB3PR0202MB3402:
X-Microsoft-Antispam-PRVS: <DB3PR0202MB340219C7623D0BFAFC8F31E1BC629@DB3PR0202MB3402.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PgyXWqERHqJdba888DTDD9ss+YpzNT0Uw8a1qnCK77lUDd/0znxdwyhG/1TNmE/9h3gmI72Mpywct1Hp5OI516ZvLour5vX6679R4pAX+iTAy0LKwKyh+q2qCIdVmYZs2rO+preRmjGmlaJJL1pMe+eHLDRcQ2Om3alEa2kPYE+onwk1lEYE9ioSFezOvUYZjIDJtN3UMRA4/Paz0270ZgCTWCOW6zKVPOJvGkQCOEP3Tr3ETkHBuMtFFl3ImkU9dnbExa3Tk38TM9kH+wWyuPWP8EhVSu0AJxWNoq93LUigKLwyaebk/P+3YVqgUvF+bHIXE1cqr1GnGYeBeXsc0bIVbYKuffel56WIgxZxA/fSvDZ9SV1xQBtjoTDJ+kdVq6GNXVEgrwGX1FkruecilLZuoSYPjTSZFeVyMqLcjUNeoGzaBoacGgmy4sgvotWroUnWv4cDuL9YE2oOGPEkl5COLVpNjUPnf2sltqDqyiv+TkuxR7P3Ol9SlmE89YCRjfdJJ+FXsUuSEdU572pSFGTirQyb4FRbOkLB+PLO5hvGE4yoN7FFKTnefzTbFCSwIdt+giUKEqJetmI6+hk0E5n0IG4iEWjNOePuVecxW8Aw0g+Cu6aVXsHjNE7inJ2RDel4XEyJmCMWf097O5cJNZJHtG9be3qa5l+PWsBbHihdzyRFqPp3iBtPE7jwjzgu4PHT/oWIF73X0Pm0ZahkkduaNU928e16zQB2swJePjIcXBTdMIQ81EguWpNW7b45
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR02MB5482.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(396003)(39840400004)(53546011)(5660300002)(4001150100001)(8676002)(26005)(186003)(316002)(54906003)(4326008)(7416002)(36916002)(8936002)(2906002)(16576012)(83380400001)(6916009)(38100700002)(31696002)(86362001)(36756003)(66476007)(66946007)(31686004)(6486002)(508600001)(2616005)(30864003)(956004)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dktQWjIwSDlKM29rb0NKNVNoZjE3b05GTmZWZ1ZpTTJLMXRFUnFXUFlGaXR4?=
 =?utf-8?B?MTZCMDBiblp5NFZUWlVueHUyRGZNOCtNZ1VodkFaOGNYcWVDdzRCNjJ0MGZR?=
 =?utf-8?B?dUJjWmFBc1gvRGJtYk5HM3lhTngzM2tXMkRsQm5IWG5EVERwTU5zV09FbXoy?=
 =?utf-8?B?OHd5Q0E1OTFZcHVmVERtUUJHUk9vMG9UZExoNFlmUG9ZTzg4Um56MDRRQzNj?=
 =?utf-8?B?WkgyRWpGdkxIWFoyb1JBdUpERVkxcm9JcWQ2dFZjd2x2cXl5WE9VOXdlT0VI?=
 =?utf-8?B?U3Z5aUtqclJsT3JSUkJSeHpScW9HSTJVTVRFN3NWbXZ0U1FkK0xqYm4yQkRk?=
 =?utf-8?B?Tks5UlRyMFdhclNPYzYybnFBRkMzK3RsY2hxMGRhdjFTMXpnMU0rdHpJRXdu?=
 =?utf-8?B?UkFTNEFXMExFa2hEckwycWNML2VHSE8wZjBBeXkyVmFSakVRaWZsSjh6RWR6?=
 =?utf-8?B?U2dkVytndXFoalZwUDY0VXd1U3VyR0o1VWJLSTlGcTRtWTFWQnVqOXgveUlW?=
 =?utf-8?B?WVY4OGhLczNKZmszTGIyamZWUnY2bDVsOFliUEYwVkZ4OHZJdGtIbjR0L0h1?=
 =?utf-8?B?Z3RtZmRZSENsNDg2STFMNU5XTENKY2I4M3lialdIcVNhL3I4U3o4NElJVUQ0?=
 =?utf-8?B?eDR4SlhBd2RlZGU0NG9ONnkzNFMrdEdhZTZvT0I1VkFyQk0yQmgzQlhlbm9i?=
 =?utf-8?B?QWpnZmJlck9oL3VzcFRtOHJBaFV3bGU3dEcyaGhjMkJPMGN2ZFBWRFV0bmVI?=
 =?utf-8?B?SnN4Y0pDWnM0Qm14NGVXb0lwNjlvQkx1a2xmUzhPREpNbUtaL2tGenJUWHAw?=
 =?utf-8?B?dzRBc0RYc0QxTk1xMlhaYVU1K1lnNklhRGViNTdKblh2NVZ4cWVwcVBoTkFy?=
 =?utf-8?B?dWZlS25zSkd3eThBVGwzanEvVXpDNUE4STZDZnhvV2FpUjZ4Q0l5bklOSzM3?=
 =?utf-8?B?UTZlL0FNelVRS1FOVEg5WUdUd1A4bExEKzZIbHZjWi95bFNSaCtUdHFQSFRQ?=
 =?utf-8?B?RitnV3UrUmMxWm1mV1V1VU1YYlQzRlhzRjU4b042WFdqOUlybmw1M2NPOE9i?=
 =?utf-8?B?bkFqYlpsamlPR1lGOG93Ly9Cd2JMYmxXUXduTmRmdUdhZ01La3dEN3d4czlM?=
 =?utf-8?B?bHJZWEoxM0FlbUQ5VEZTemU3S1RTRkthOWVnQS9HajFkZGpmVWxqMDFZWCtr?=
 =?utf-8?B?Qi9rMll6U2NHNThqQnZxeDRiNFpPWUU1NlVoZlFERTEvL2hGenEwSHlHKzZq?=
 =?utf-8?B?UHIxK25aeG1WNUdIcE5lMnFCaU1ZWVBxSEw3cWlzaE9aYjRNRnNpNjdSNXBp?=
 =?utf-8?B?aVl0cVRIamVQcFB3VHhnc0NXTkJ0djZ2ZWFOMjRyekRGanZOZVE4UmVWS1Ra?=
 =?utf-8?B?alF1S2cvUzdndTFSNHN5WG03YW5BMjhLdis1cGx5OXhDOUlyam40NS9nRWdq?=
 =?utf-8?B?MnBOaFZuNXoyb0xyZGo3aDh5UFJpRlE2c0NZMnZrY0Y2WVNvQlU0aGVkejg3?=
 =?utf-8?B?SXJiTHIrNmRPT010K1BOUjc1ek5MZ2puZzQ5YXBGL0MzcFkyMi9kcmNKWllz?=
 =?utf-8?B?NU5NR2UrSGJGTk9XNmd6c1VxdlRhSEF5dTBZTFRIZExFb25PKzE2aTBmWXAr?=
 =?utf-8?B?alZ6YTZTb21LTm96Q2EzS2NtWEJqMFBMTXovVFRXQ0crdkFOOU1taGtlVlFN?=
 =?utf-8?B?UmgyTzNPSUxRQ1FZdk5RbEkyQncrYmd0L21ZaW5HZFU0VmswQlR4VEthc0JX?=
 =?utf-8?B?R25oU1oxQ1MyNWlna0RqWkVIWEhDelRrNTNad2FHM21NMXg4eFowcXJqM3Zm?=
 =?utf-8?B?RjBVQVE4U3daMnhzQ3FkYXJBUlNIcE5vM1NkTUNJQ1E5U3ZpY0QzZHlMbGxh?=
 =?utf-8?B?cEVVdWs4ci9Jbk5DTDM3aGh2U1ZHdzNEVDVObmpVY3pmZjJYVFphUTNDZnRK?=
 =?utf-8?B?WCtyemV5ajN3NmR0dlM5eE5QQ0QvdlhSV1Z3N3diLzF2NU5WMTh3U292eUdm?=
 =?utf-8?B?VmE4VFJqUy9QTFZhbWZCZzlrOVIzQ2QxYWhrUUUxMmFXK0dkVk9UWlhNeVpM?=
 =?utf-8?B?UThBTHUwcmp0b1hBUmduYXFYYkEvcUc4YXZQWGE3RjhFZnllU0EyRCtTcVU0?=
 =?utf-8?Q?Mxpc=3D?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c251f5-3e7c-4781-bfec-08d9b01ac555
X-MS-Exchange-CrossTenant-AuthSource: DB8PR02MB5482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 13:52:07.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gRStOhqv+wcrwBBWKRlVc9khvZksR644Ghy+yjZbcqk6jfei312rFOeBLI5eikyN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB3402
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi!

On 2021-11-23 09:12, Aswath Govindraju wrote:
> In some cases, we might need to provide the state of the mux to be set for
> the operation of a given peripheral. Therefore, pass this information using
> the second argument of the mux-controls property.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  drivers/mux/core.c           | 146 ++++++++++++++++++++++++++++++++++-
>  include/linux/mux/consumer.h |  19 ++++-
>  include/linux/mux/driver.h   |  13 ++++
>  3 files changed, 173 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 22f4709768d1..9622b98f9818 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -370,6 +370,29 @@ int mux_control_select_delay(struct mux_control *mux, unsigned int state,
>  }
>  EXPORT_SYMBOL_GPL(mux_control_select_delay);
>  
> +/**
> + * mux_state_select_delay() - Select the enable state in mux-state

The terminology is that you have a "mux" with different "states" that you
"select". What you are referring to as enabling a mux state, is elsewhere
referred to as selecting the mux state.

> + * @mux: The mux-state to request a change of state from.
> + * @delay_us: The time to delay (in microseconds) if the mux state is changed.
> + *
> + * On successfully selecting the enable state, it will be locked until
> + * there is a call to mux_state_deselect(). If the mux-control is already
> + * selected when mux_state_select() is called, the caller will be blocked
> + * until mux_state_deselect() is called (by someone else).
> + *
> + * Therefore, make sure to call mux_state_deselect() when the operation is
> + * complete and the mux-control is free for others to use, but do not call
> + * mux_state_deselect() if mux_state_select() fails.
> + *
> + * Return: 0 when the mux-state has the enable state or a negative
> + * errno on error.
> + */
> +int mux_state_select_delay(struct mux_state *mux, unsigned int delay_us)

I dislike the name "mux" here, that name is consistently referring to
a struct mux-control in the mux subsystem. If mux_state is too long,
maybe mstate or something such, just not plain mux. That goes for all
the struct mux_state variables that follow too. I.e. pick a new name
for variables of this type and stick to it (unless you need more than
one such variable in a context, of course).

> +{
> +	return mux_control_select_delay(mux->mux, mux->enable_state, delay_us);
> +}
> +EXPORT_SYMBOL_GPL(mux_state_select_delay);

Taking the above into account, I would like to see:

/**
 * mux_state_select_delay() - Select the mux-state
 * @mstate: The mux-state to select.
 * @delay_us: The time to delay (in microseconds) if the mux-control changes
 *            state on select.
 *
 * On successfully selecting the mux-state, its mux-control will be locked
 * until there is a call to mux_state_deselect(). If the mux-control is
 * already selected when mux_state_select() is called, the caller will be
 * blocked until the mux-control is deselected (by someone else).
 *
 * Therefore, make sure to call mux_state_deselect() when the operation is
 * complete and the mux-control is free for others to use, but do not call
 * mux_state_deselect() if mux_state_select() fails.
 *
 * Return: 0 when the mux-state has been selected or a negative errno on
 * error.
 */
int mux_state_select_delay(struct mux_state *mstate, unsigned int delay_us)

And then similar changes for the other new mux_state_ functions.

> +
>  /**
>   * mux_control_try_select_delay() - Try to select the given multiplexer state.
>   * @mux: The mux-control to request a change of state from.
> @@ -405,6 +428,27 @@ int mux_control_try_select_delay(struct mux_control *mux, unsigned int state,
>  }
>  EXPORT_SYMBOL_GPL(mux_control_try_select_delay);
>  
> +/**
> + * mux_state_try_select_delay() - Try to select the multiplexer enable state.
> + * @mux: The mux-control to request a change of state from.
> + * @delay_us: The time to delay (in microseconds) if the mux state is changed.
> + *
> + * On successfully selecting the enable state, it will be locked until
> + * mux_state_deselect() called.
> + *
> + * Therefore, make sure to call mux_state_deselect() when the operation is
> + * complete and the mux-control is free for others to use, but do not call
> + * mux_state_deselect() if mux_state_try_select() fails.
> + *
> + * Return: 0 when the mux-control state has the requested state or a negative
> + * errno on error. Specifically -EBUSY if the mux-control is contended.
> + */
> +int mux_state_try_select_delay(struct mux_state *mux, unsigned int delay_us)
> +{
> +	return mux_control_try_select_delay(mux->mux, mux->enable_state, delay_us);
> +}
> +EXPORT_SYMBOL_GPL(mux_state_try_select_delay);
> +
>  /**
>   * mux_control_deselect() - Deselect the previously selected multiplexer state.
>   * @mux: The mux-control to deselect.
> @@ -431,6 +475,24 @@ int mux_control_deselect(struct mux_control *mux)
>  }
>  EXPORT_SYMBOL_GPL(mux_control_deselect);
>  
> +/**
> + * mux_state_deselect() - Deselect the previously selected multiplexer state.
> + * @mux: The mux-state to deselect.
> + *
> + * It is required that a single call is made to mux_state_deselect() for
> + * each and every successful call made to either of mux_state_select() or
> + * mux_state_try_select().
> + *
> + * Return: 0 on success and a negative errno on error. An error can only
> + * occur if the mux has an idle state. Note that even if an error occurs, the
> + * mux-control is unlocked and is thus free for the next access.
> + */
> +int mux_state_deselect(struct mux_state *mux)
> +{
> +	return mux_control_deselect(mux->mux);
> +}
> +EXPORT_SYMBOL_GPL(mux_state_deselect);
> +
>  /* Note this function returns a reference to the mux_chip dev. */
>  static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
>  {
> @@ -442,13 +504,15 @@ static struct mux_chip *of_find_mux_chip_by_node(struct device_node *np)
>  }
>  
>  /**
> - * mux_control_get() - Get the mux-control for a device.
> + * mux_get() - Get the mux-control for a device.
>   * @dev: The device that needs a mux-control.
>   * @mux_name: The name identifying the mux-control.
> + * @enable_state: The variable to store the enable state for the requested device
>   *
>   * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
>   */
> -struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
> +static struct mux_control *mux_get(struct device *dev, const char *mux_name,
> +				   unsigned int *enable_state)

s/enable_state/state/ (goes for all of the patch).

>  {
>  	struct device_node *np = dev->of_node;
>  	struct of_phandle_args args;
> @@ -481,8 +545,7 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  	if (!mux_chip)
>  		return ERR_PTR(-EPROBE_DEFER);
>  
> -	if (args.args_count > 1 ||

It is inconsistent to allow more than 2 args, but then only allow
digging out the state from the 2nd arg if the count is exactly 2.

> -	    (!args.args_count && (mux_chip->controllers > 1))) {
> +	if (!args.args_count && mux_chip->controllers > 1) {
>  		dev_err(dev, "%pOF: wrong #mux-control-cells for %pOF\n",
>  			np, args.np);
>  		put_device(&mux_chip->dev);
> @@ -500,8 +563,25 @@ struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	if (args.args_count == 2)
> +		*enable_state = args.args[1];
> +

With the suggested binding in my comment for patch 1/4, you'd need to do
either

	ret = of_parse_phandle_with_args(np,
					 "mux-controls", "#mux-control-cells",
					 index, &args);

or

	ret = of_parse_phandle_with_args(np,
					 "mux-states", "#mux-state-cells",
					 index, &args);

depending on if the mux_get helper gets a NULL (enable_)state pointer or a "real"
address, and then...

>  	return &mux_chip->mux[controller];
>  }
> +
> +/**
> + * mux_control_get() - Get the mux-control for a device.
> + * @dev: The device that needs a mux-control.
> + * @mux_name: The name identifying the mux-control.
> + *
> + * Return: A pointer to the mux-control, or an ERR_PTR with a negative errno.
> + */
> +struct mux_control *mux_control_get(struct device *dev, const char *mux_name)
> +{
> +	int state;
> +
> +	return mux_get(dev, mux_name, &state);

...pass NULL as the 3rd arg here.

> +}
>  EXPORT_SYMBOL_GPL(mux_control_get);
>  
>  /**
> @@ -523,6 +603,26 @@ static void devm_mux_control_release(struct device *dev, void *res)
>  	mux_control_put(mux);
>  }
>  
> +/**
> + * mux_state_put() - Put away the mux-state for good.
> + * @mux: The mux-state to put away.
> + *
> + * mux_control_put() reverses the effects of mux_control_get().
> + */
> +void mux_state_put(struct mux_state *mux_state)
> +{
> +	mux_control_put(mux_state->mux);
> +	kfree(mux_state);
> +}
> +EXPORT_SYMBOL_GPL(mux_state_put);
> +
> +static void devm_mux_state_release(struct device *dev, void *res)
> +{
> +	struct mux_state *mux = *(struct mux_state **)res;
> +
> +	mux_state_put(mux);
> +}
> +
>  /**
>   * devm_mux_control_get() - Get the mux-control for a device, with resource
>   *			    management.
> @@ -553,6 +653,44 @@ struct mux_control *devm_mux_control_get(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_mux_control_get);
>  
> +/**
> + * devm_mux_state_get() - Get the mux-state for a device, with resource
> + *			  management.
> + * @dev: The device that needs a mux-control.
> + * @mux_name: The name identifying the mux-control.
> + *
> + * Return: Pointer to the mux-state, or an ERR_PTR with a negative errno.
> + */
> +struct mux_state *devm_mux_state_get(struct device *dev,
> +				     const char *mux_name)
> +{
> +	struct mux_state **ptr, *mux_state;
> +	struct mux_control *mux_ctrl;
> +	int enable_state;
> +
> +	mux_state = devm_kzalloc(dev, sizeof(struct mux_state), GFP_KERNEL);
> +	if (!mux_state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ptr = devres_alloc(devm_mux_state_release, sizeof(*ptr), GFP_KERNEL);
> +	if (!ptr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mux_ctrl = mux_get(dev, mux_name, &enable_state);
> +	if (IS_ERR(mux_ctrl)) {
> +		devres_free(ptr);
> +		return (struct mux_state *)mux_ctrl;
> +	}
> +
> +	mux_state->mux = mux_ctrl;
> +	mux_state->enable_state = enable_state;
> +	*ptr = mux_state;
> +	devres_add(dev, ptr);
> +
> +	return mux_state;
> +}
> +EXPORT_SYMBOL_GPL(devm_mux_state_get);
> +
>  /*
>   * Using subsys_initcall instead of module_init here to try to ensure - for
>   * the non-modular case - that the subsystem is initialized when mux consumers
> diff --git a/include/linux/mux/consumer.h b/include/linux/mux/consumer.h
> index 7a09b040ac39..d0f3242e148d 100644
> --- a/include/linux/mux/consumer.h
> +++ b/include/linux/mux/consumer.h
> @@ -14,33 +14,50 @@
>  
>  struct device;
>  struct mux_control;
> +struct mux_state;
>  
>  unsigned int mux_control_states(struct mux_control *mux);
>  int __must_check mux_control_select_delay(struct mux_control *mux,
>  					  unsigned int state,
>  					  unsigned int delay_us);
> +int __must_check mux_state_select_delay(struct mux_state *mux,
> +					unsigned int delay_us);
>  int __must_check mux_control_try_select_delay(struct mux_control *mux,
>  					      unsigned int state,
>  					      unsigned int delay_us);
> -
> +int __must_check mux_state_try_select_delay(struct mux_state *mux,
> +					    unsigned int delay_us);
>  static inline int __must_check mux_control_select(struct mux_control *mux,
>  						  unsigned int state)
>  {
>  	return mux_control_select_delay(mux, state, 0);
>  }
>  
> +static inline int __must_check mux_state_select(struct mux_state *mux)
> +{
> +	return mux_state_select_delay(mux, 0);
> +}
>  static inline int __must_check mux_control_try_select(struct mux_control *mux,
>  						      unsigned int state)
>  {
>  	return mux_control_try_select_delay(mux, state, 0);
>  }
>  
> +static inline int __must_check mux_state_try_select(struct mux_state *mux)
> +{
> +	return mux_state_try_select_delay(mux, 0);
> +}
> +
>  int mux_control_deselect(struct mux_control *mux);
> +int mux_state_deselect(struct mux_state *mux);
>  
>  struct mux_control *mux_control_get(struct device *dev, const char *mux_name);
>  void mux_control_put(struct mux_control *mux);
> +void mux_state_put(struct mux_state *mux);
>  
>  struct mux_control *devm_mux_control_get(struct device *dev,
>  					 const char *mux_name);
> +struct mux_state *devm_mux_state_get(struct device *dev,
> +				     const char *mux_name);
>  
>  #endif /* _LINUX_MUX_CONSUMER_H */
> diff --git a/include/linux/mux/driver.h b/include/linux/mux/driver.h
> index 18824064f8c0..c7236f307fbd 100644
> --- a/include/linux/mux/driver.h
> +++ b/include/linux/mux/driver.h
> @@ -53,6 +53,19 @@ struct mux_control {
>  	ktime_t last_change;
>  };
>  
> +/**
> + * struct mux_state -	Represents a mux controller specific to a given device
> + * @mux:		Pointer to a mux controller
> + * @enable_state	State of the mux to be set for enabling a device
> + *
> + * This structure is specific to a device that acquires it and has information
> + * specific to the device.
> + */
> +struct mux_state {
> +	struct mux_control *mux;
> +	unsigned int enable_state;
> +};
> +
>  /**
>   * struct mux_chip -	Represents a chip holding mux controllers.
>   * @controllers:	Number of mux controllers handled by the chip.
> 

This struct does not belong in driver.h, as it's purely a consumer thing.
That said, it need not be in consumer.h either, as there is no need to
"expose" the struct guts in any header. Just add it directly in core.c
which is the only file that digs around in the struct.

Cheers,
Peter
