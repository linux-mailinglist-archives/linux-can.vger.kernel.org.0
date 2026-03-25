Return-Path: <linux-can+bounces-7249-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id c/3FKAnQw2lBuQQAu9opvQ
	(envelope-from <linux-can+bounces-7249-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 25 Mar 2026 13:07:37 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0AE32473D
	for <lists+linux-can@lfdr.de>; Wed, 25 Mar 2026 13:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03D333088B18
	for <lists+linux-can@lfdr.de>; Wed, 25 Mar 2026 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268DB3D16EA;
	Wed, 25 Mar 2026 11:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8VoBQpQ"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F1B3CF69F;
	Wed, 25 Mar 2026 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439487; cv=none; b=LtIFpnEq+fdW55N0lJ5KjLHwqz87QXBw7t2gi7SzQ7WC814dygtZXndhoCn1Bx2/SXsCq5ud5BI74XpT/UP/TgOirNOtaunKyg83c8Uy2R+Fbbo1JcMIAyT+Hcv8Ajr3Bye/+MsXhiJzOd6dMbKfTJ02KTrq3Ea4R5ysytVFEX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439487; c=relaxed/simple;
	bh=ijQZYkQ8huX8bzZfiuwKK5l/O+taUFGXBf7mUcCwX/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgOg2gNFWYMdKBukorfVPT0egm7iZMc+USBbiVREq5qDEdcDrbeYPC6pdtyvYlAWfcnLf3KVYdmhKXHOHEwesGnjA0PunUqH46app9F39WhIdP3Cbk7REtG3OQV3wggnjt633paRVfin0oILpi3CKmgdwUudOG/CCcXXxgba4CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8VoBQpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F905C2BCB2;
	Wed, 25 Mar 2026 11:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774439486;
	bh=ijQZYkQ8huX8bzZfiuwKK5l/O+taUFGXBf7mUcCwX/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F8VoBQpQxXDFHPLwjgn+FimF064VYiGnb02ISTZuo7sMCK/Or3p4aIxqTZnuLA+uL
	 /r3T+Vz7lEc5yc54KjVTpnI+VbV4XN+l9Nl46axhDOOVHgzVdpo/UGmLK8hQXPEUNR
	 ynBx5dd5yG3uJQWeeWTgH1cW2In1W0YVJ8QoBnAUk6K4WIL8a0REi+e01oXpRwalXe
	 gSeFc6w+k+DbJNNIa/GojyKKWjfTcx03289D4/2LfiEs6Mel5pKCUogETaR2OKLgYy
	 1ahoOxct2eimH12qdt9HBRcDZVXFXVZm9/7QyfTkESgul2vKzgUyr+V1bDmNBkVBYO
	 nsJxO9bsBzs0w==
Date: Wed, 25 Mar 2026 17:21:14 +0530
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
Message-ID: <vu3cxpynr5mu2fzkrtmjcwijc5jz323wlnbc3r7lp2wxqmhydx@z5xhgf4myw2d>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-11-vladimir.oltean@nxp.com>
 <ezrcjjwtg5n76w4m65l27szu5mywx66ti3xuprkfcp3x6quvbf@2rew4zrnnbt2>
 <20260325114309.3k7xkfrffpxp5xq4@skbuf>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325114309.3k7xkfrffpxp5xq4@skbuf>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7249-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D0AE32473D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 01:43:09PM +0200, Vladimir Oltean wrote:
> On Tue, Mar 24, 2026 at 11:00:10AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Mar 20, 2026 at 12:32:24AM +0200, Vladimir Oltean wrote:
> > > As explained in the similar ufs-exynos.c change, PHY consumer drivers
> > > should not look at the phy->power_count, because in the general case
> > > there might also be other consumers who have called phy_power_on() too,
> > > so the fact that the power_count is non-zero does not mean that we did.
> > > 
> > > Moreover, struct phy will become opaque soon, so the qcom UFS driver
> > > will not be able to apply this pattern. Keep parallel track of the PHY
> > > power state, instead of looking at a field which will become unavailable
> > > (phy->power_count).
> > > 
> > > About treating the phy_power_off() return code: from an API perspective,
> > > this should have probably returned void, otherwise consumers would be
> > > stuck in a state they can't escape. The provider, phy-qcom-qmp-ufs.c,
> > > does return 0 in its power_off() implementation. I consider it safe to
> > > discard potential errors from phy_power_off() instead of complicating
> > > the phy_powered_on logic.
> > > 
> > 
> > You could even simplify the code by getting rid of the 'phy_powered_on' check
> > altogether. There is no real need to track the PHY power state in this driver.
> > It is safe to call phy_power_off() without any checks.
> > 
> > - Mani
> 
> Ok.. as the author of commit 7bac65687510 ("scsi: ufs: qcom: Power off
> the PHY if it was already powered on in ufs_qcom_power_up_sequence()"),
> I assume you have hardware to test. Would you mind writing a patch that
> I could pick up to replace this one with?
> 

Sure, will do.

> I suppose that the power_count test is somehow no longer necessary after
> commit 77d2fa54a945 ("scsi: ufs: qcom : Refactor phy_power_on/off
> calls"), but frankly I don't see it - the ufshcd state machine is a bit
> too complicated for me to just statically analyze.

I believe I added the power_count check for phy_exit(). But since that got
moved, the check becomes no longer necessary.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

