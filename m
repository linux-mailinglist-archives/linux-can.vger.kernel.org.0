Return-Path: <linux-can+bounces-7236-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AFUB3YhwmnHZgQAu9opvQ
	(envelope-from <linux-can+bounces-7236-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 06:30:30 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1593023FA
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 06:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 107B33039EC0
	for <lists+linux-can@lfdr.de>; Tue, 24 Mar 2026 05:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C55D23183F;
	Tue, 24 Mar 2026 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwWTEQB3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23792175A68;
	Tue, 24 Mar 2026 05:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774330227; cv=none; b=nsyYgyCw2NAXcTTInDi34iQ0ibhtYFkFh8cVMwLgHpCaEqZoAhT07o7/iK4mbFEGn0M4ErHzA1UhA3Gcf+wZBKXKXFryLKYPUHVWhThPjLVp4PoB92ejPpQqpOx24iigtOsuZbCsSrKtRIkmJ/yZEjrnoVz9rbn9CHDmJDCRTUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774330227; c=relaxed/simple;
	bh=526IhjsOFPVmG2tNWNSg5v0vlx2brzpXsRolpXsjTxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An5CmZRstep0cxpg/2N/1a7x3tx7/s1KWQxWxDZa8G2/n2TN5dj9gJqdK8bzzV3hgYKp07Mb4Qp/3n4HewvTHvM4+SIrOr2tTSQnEhH2s/6dSgZ7ndhLK4Q+mBQO+D30BbnRyN7ztc+/vBnFMJBVMGB4vWwxcQA31uEKF7c+jNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwWTEQB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB708C19424;
	Tue, 24 Mar 2026 05:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774330227;
	bh=526IhjsOFPVmG2tNWNSg5v0vlx2brzpXsRolpXsjTxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IwWTEQB3juSgzdL+5oAblN8Vg5C2TndIzXIJ+/psD+qLI87dPTnoZjI03lh86g1OB
	 mpSx1LZMSw/DBe07y/3Zp7OwHRoXIwmNyksCLyArn6Wgy/ZHCvMbVGNpS90y0hARXP
	 F0cEESScMmvPYn5UufI98xv5QMoRbgZrZzhD7xIu0KifQHEz3rXAPZncO9dZT6B7kz
	 f7eteFWu1GwBo5+I9vrgiWwlDtSUwgSH1mRAXD6RYsxRwmK/CWvAd8Nwsx8c7aA7z2
	 z6dYz7z5nVUXZFH9xdB88UIr+/EMARSpJjWMql6MVkuv6lSlxP20W2BfZ5GZOiuE6l
	 rVsq+mtBjuYfg==
Date: Tue, 24 Mar 2026 11:00:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-tegra@vger.kernel.org, linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	spacemit@lists.linux.dev, UNGLinuxDriver@microchip.com, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Nitin Rawat <quic_nitirawa@quicinc.com>
Subject: Re: [PATCH v5 phy-next 10/27] scsi: ufs: qcom: keep parallel track
 of PHY power state
Message-ID: <ezrcjjwtg5n76w4m65l27szu5mywx66ti3xuprkfcp3x6quvbf@2rew4zrnnbt2>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-11-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260319223241.1351137-11-vladimir.oltean@nxp.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7236-lists,linux-can=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quicinc.com:email]
X-Rspamd-Queue-Id: 6D1593023FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 12:32:24AM +0200, Vladimir Oltean wrote:
> As explained in the similar ufs-exynos.c change, PHY consumer drivers
> should not look at the phy->power_count, because in the general case
> there might also be other consumers who have called phy_power_on() too,
> so the fact that the power_count is non-zero does not mean that we did.
> 
> Moreover, struct phy will become opaque soon, so the qcom UFS driver
> will not be able to apply this pattern. Keep parallel track of the PHY
> power state, instead of looking at a field which will become unavailable
> (phy->power_count).
> 
> About treating the phy_power_off() return code: from an API perspective,
> this should have probably returned void, otherwise consumers would be
> stuck in a state they can't escape. The provider, phy-qcom-qmp-ufs.c,
> does return 0 in its power_off() implementation. I consider it safe to
> discard potential errors from phy_power_off() instead of complicating
> the phy_powered_on logic.
> 

You could even simplify the code by getting rid of the 'phy_powered_on' check
altogether. There is no real need to track the PHY power state in this driver.
It is safe to call phy_power_off() without any checks.

- Mani

> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: Nitin Rawat <quic_nitirawa@quicinc.com>
> 
> v4->v5: patch is new
> ---
>  drivers/ufs/host/ufs-qcom.c | 9 +++++++--
>  drivers/ufs/host/ufs-qcom.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 375fd24ba458..3b8bd9968235 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -508,9 +508,10 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  	if (ret)
>  		return ret;
>  
> -	if (phy->power_count)
> +	if (host->phy_powered_on) {
>  		phy_power_off(phy);
> -
> +		host->phy_powered_on = false;
> +	}
>  
>  	/* phy initialization - calibrate the phy */
>  	ret = phy_init(phy);
> @@ -531,6 +532,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
>  			__func__, ret);
>  		goto out_disable_phy;
>  	}
> +	host->phy_powered_on = true;
>  
>  	ret = phy_calibrate(phy);
>  	if (ret) {
> @@ -1268,6 +1270,7 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
>  				dev_err(hba->dev, "phy power off failed, ret=%d\n", err);
>  				return err;
>  			}
> +			host->phy_powered_on = false;
>  		}
>  		break;
>  	case POST_CHANGE:
> @@ -1277,6 +1280,7 @@ static int ufs_qcom_setup_clocks(struct ufs_hba *hba, bool on,
>  				dev_err(hba->dev, "phy power on failed, ret = %d\n", err);
>  				return err;
>  			}
> +			host->phy_powered_on = true;
>  
>  			/* enable the device ref clock for HS mode*/
>  			if (ufshcd_is_hs_mode(&hba->pwr_info))
> @@ -1467,6 +1471,7 @@ static void ufs_qcom_exit(struct ufs_hba *hba)
>  
>  	ufs_qcom_disable_lane_clks(host);
>  	phy_power_off(host->generic_phy);
> +	host->phy_powered_on = false;
>  	phy_exit(host->generic_phy);
>  }
>  
> diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
> index 1111ab34da01..72ce0687fa42 100644
> --- a/drivers/ufs/host/ufs-qcom.h
> +++ b/drivers/ufs/host/ufs-qcom.h
> @@ -282,6 +282,7 @@ struct ufs_qcom_host {
>  	struct clk_bulk_data *clks;
>  	u32 num_clks;
>  	bool is_lane_clks_enabled;
> +	bool phy_powered_on;
>  
>  	struct icc_path *icc_ddr;
>  	struct icc_path *icc_cpu;
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

