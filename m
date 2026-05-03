Return-Path: <linux-can+bounces-7464-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOFQJ19/92lsiQIAu9opvQ
	(envelope-from <linux-can+bounces-7464-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 03 May 2026 19:01:19 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF6E4B6B6A
	for <lists+linux-can@lfdr.de>; Sun, 03 May 2026 19:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5B61C3001478
	for <lists+linux-can@lfdr.de>; Sun,  3 May 2026 17:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F6D3D16E8;
	Sun,  3 May 2026 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIMXEHyi"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8793D091E;
	Sun,  3 May 2026 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827658; cv=none; b=rYxJCFEF4ZB/vCDgLBwzkd28sJcyKpYMoc/9R7GqkgbxuzpVY8vlsLCiH5X1ab7GcUK1yUxJrOdWb3ilkfDIxV2Dv80gjJo81I5h6eJf3APIzvdCrjqDktxBYNXpttVkUjTyuFjH/uyvIP9D8t0TK20lzo9kT+4l70jZ8XqM43g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827658; c=relaxed/simple;
	bh=dPTS7oWEl7liSt0nD0Gew0CooOhSXFn2gDh15RnBpKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJnh3Q5T8M6yM9aF2qwHPbbC7wDPc5s+ivRhXnprVu/rYqMX5W/y1Kahs/AlVd4P66scCfncSnXmBXsfvAG+c2Y5EEZmfexgNl/2kpr9DqHUU4xtQOqQei0gGOEcP7StATwjztgyEKJO8M+aOfH+K/PVCIQH52LxJQXpUpvzf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIMXEHyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23789C2BCB4;
	Sun,  3 May 2026 17:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777827657;
	bh=dPTS7oWEl7liSt0nD0Gew0CooOhSXFn2gDh15RnBpKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CIMXEHyiaEFFWa02vilwPSZZac1Yxffrn1GuHb+9NX2Z9tlxcLARu+gSFTdRJOYfz
	 VgXcAVwLBUvw5eqaugcuvhRmYZ+wy43GVGRz/Bkx3DtarSKTQ7xh4sFz8DfIo6cKrQ
	 xkWPNw74AT/O7YdVbWEL+vzKmY1tW0kpxDiWcS56zL95Mde8pOApun6c1BHs5I/8rd
	 q7nIRg0s6SxbAIBqLtPGrGhqqmjAMCjgMThVehQBQyTIQ8MTHfcrjM2br3iZ2dhiK3
	 tYJCpvf35v6b2EKi2B7RSlooiViRM9J5AF7Seoml5gEsXVAG0z4gbNrE7Fr0XemyZh
	 Hr4yPhB/Mogxg==
Date: Sun, 3 May 2026 22:30:53 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/4] phy: phy-can-transceiver: Move OF ID table closer
 to their user
Message-ID: <afd_RXYvsU5OogPX@vaman>
References: <20260317203001.2108568-1-andriy.shevchenko@linux.intel.com>
 <20260317203001.2108568-3-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317203001.2108568-3-andriy.shevchenko@linux.intel.com>
X-Rspamd-Queue-Id: 5CF6E4B6B6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7464-lists,linux-can=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vkoul@kernel.org,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]

On 17-03-26, 21:27, Andy Shevchenko wrote:
> There is no code that uses ID table directly, except the
> struct device_driver at the end of the file. Hence, move
> table closer to its user. It's always possible to access
> them via a pointer.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/phy/phy-can-transceiver.c | 59 +++++++++++++++----------------
>  1 file changed, 29 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
> index 80eece74f77d..aaed8d08fcf0 100644
> --- a/drivers/phy/phy-can-transceiver.c
> +++ b/drivers/phy/phy-can-transceiver.c
> @@ -97,35 +97,6 @@ static const struct can_transceiver_data tja1057_drvdata = {
>  	.flags = CAN_TRANSCEIVER_SILENT_PRESENT,
>  };
>  
> -static const struct of_device_id can_transceiver_phy_ids[] = {
> -	{
> -		.compatible = "ti,tcan1042",
> -		.data = &tcan1042_drvdata
> -	},
> -	{
> -		.compatible = "ti,tcan1043",
> -		.data = &tcan1043_drvdata
> -	},
> -	{
> -		.compatible = "nxp,tja1048",
> -		.data = &tja1048_drvdata
> -	},
> -	{
> -		.compatible = "nxp,tja1051",
> -		.data = &tja1051_drvdata
> -	},
> -	{
> -		.compatible = "nxp,tja1057",
> -		.data = &tja1057_drvdata
> -	},
> -	{
> -		.compatible = "nxp,tjr1443",
> -		.data = &tcan1043_drvdata
> -	},
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
> -
>  static struct phy *can_transceiver_phy_xlate(struct device *dev,
>  					     const struct of_phandle_args *args)
>  {
> @@ -229,6 +200,35 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
>  	return PTR_ERR_OR_ZERO(phy_provider);
>  }
>  
> +static const struct of_device_id can_transceiver_phy_ids[] = {
> +	{
> +		.compatible = "ti,tcan1042",
> +		.data = &tcan1042_drvdata
> +	},
> +	{
> +		.compatible = "ti,tcan1043",
> +		.data = &tcan1043_drvdata
> +	},
> +	{
> +		.compatible = "nxp,tja1048",
> +		.data = &tja1048_drvdata
> +	},
> +	{
> +		.compatible = "nxp,tja1051",
> +		.data = &tja1051_drvdata
> +	},
> +	{
> +		.compatible = "nxp,tja1057",
> +		.data = &tja1057_drvdata
> +	},
> +	{
> +		.compatible = "nxp,tjr1443",
> +		.data = &tcan1043_drvdata
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, can_transceiver_phy_ids);
> +
>  static struct platform_driver can_transceiver_phy_driver = {
>  	.probe = can_transceiver_phy_probe,
>  	.driver = {
> @@ -236,7 +236,6 @@ static struct platform_driver can_transceiver_phy_driver = {
>  		.of_match_table = can_transceiver_phy_ids,
>  	},
>  };
> -

This looks like a stray delete?

>  module_platform_driver(can_transceiver_phy_driver);
>  
>  MODULE_AUTHOR("Faiz Abbas <faiz_abbas@ti.com>");
> -- 
> 2.50.1

-- 
~Vinod

