Return-Path: <linux-can+bounces-7262-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAZtLnosxmmNHQUAu9opvQ
	(envelope-from <linux-can+bounces-7262-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 08:06:34 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1C3402E5
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 08:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B09B31F9341
	for <lists+linux-can@lfdr.de>; Fri, 27 Mar 2026 06:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D183C343F;
	Fri, 27 Mar 2026 06:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uM9tWBQS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1A12BE7BB;
	Fri, 27 Mar 2026 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774594384; cv=none; b=ESnt93odZ5ccH6QecTRpZez+pzGT89aWC5NqsSD8Fhcz/j3N18YOpxXVT0+bixAVPmssGaNK2zDc0HvmLkXEMzWwqty9HsdNmXprVtVgMdG2+G+T5L5RQWwWNWpCSTFW4enPEy2xpyRC3lru1cdjUBoELDq43oS19HqYbTfoCEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774594384; c=relaxed/simple;
	bh=+6taD/KYX6s6aOGsQO53ivGa0KI2dG/K2GEdTZ29IxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=maY8VjJ4M8ub7rY6gutpF8eIFQyvtYi1+++x2DcJwHGfOX0f41dZIGa/Utm0EM31BBTovbZ3+CXl08C+ydUVpxWWk/i4kcyZ5hKkqJpgD7zVyXn0oEDR9CpUbgRk9lHRqxSD+owzeafQuMEczQJ88UbSl9Lvv+cLesXXTneo4VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uM9tWBQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5247EC19423;
	Fri, 27 Mar 2026 06:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774594383;
	bh=+6taD/KYX6s6aOGsQO53ivGa0KI2dG/K2GEdTZ29IxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uM9tWBQSBzeOskmqaDM0QvWoV4jUNiC4DsBlIKIFg7In21qbXcrgvL+npIdvVsRu4
	 qrE69iQ+kiDSqXlcivHy16z+fEY80xVdn90vInQTF9nPU0Nfe7+PBampXS2wO/gG+p
	 NgAISEoCyX1+VSpZjmfa/Wk2xePLkgGitS5duT/iqLt2Xz6gmhtYoyq/3bAsUtsGq+
	 2OtE88H/kNHCxHKSKe13LzCtkcFHYUQtieBVLEZ/RgfH2fMVrGZXCU2jVD0wDWvbDI
	 /UHVNy1S2RfsSIT/lKpdHdy0Vk/hccjI1KCqeAffyJ+BOUCNvP4IiTCz7QCM5HVlUz
	 YXDRsPrcv0reg==
Date: Fri, 27 Mar 2026 12:22:46 +0530
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
Message-ID: <gq4sswslkjaoe5hhxe2mz6z57uiumotqknkryadvfsstj4srx4@qgenqekgrqv4>
References: <20260319223241.1351137-1-vladimir.oltean@nxp.com>
 <20260319223241.1351137-11-vladimir.oltean@nxp.com>
 <ezrcjjwtg5n76w4m65l27szu5mywx66ti3xuprkfcp3x6quvbf@2rew4zrnnbt2>
 <20260325114309.3k7xkfrffpxp5xq4@skbuf>
 <vu3cxpynr5mu2fzkrtmjcwijc5jz323wlnbc3r7lp2wxqmhydx@z5xhgf4myw2d>
 <20260325115731.genmq2yew2p4dvbs@skbuf>
 <20260326080444.gbesciaa5zwvcgoy@skbuf>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260326080444.gbesciaa5zwvcgoy@skbuf>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7262-lists,linux-can=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 39C1C3402E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 10:04:44AM +0200, Vladimir Oltean wrote:
> On Wed, Mar 25, 2026 at 01:57:31PM +0200, Vladimir Oltean wrote:
> > On Wed, Mar 25, 2026 at 05:21:14PM +0530, Manivannan Sadhasivam wrote:
> > > I believe I added the power_count check for phy_exit(). But since that got
> > > moved, the check becomes no longer necessary.
> > 
> > FYI, the power_count keeps track of the balance of phy_power_on() and
> > phy_power_off() calls, whereas it is the init_count keeps track of
> > phy_init() and phy_exit() calls. They are only related to the extent
> > that you must respect the phy_init() -> phy_power_on() -> phy_power_off()
> > -> phy_exit() sequence. But in any case, both should be considered
> > PHY-internal fields. The "Order of API calls" section from
> > Documentation/driver-api/phy/phy.rst mentions the order that I just
> > described above, and consumers should just ensure they follow that.
> 
> Ok, so we can close this topic of "checking the power_count not needed"
> by linking to the conversation which spun off here:
> https://lore.kernel.org/lkml/20260325120122.265973-1-manivannan.sadhasivam@oss.qualcomm.com/
> 

Sure.

> Mani, I spent some more time to figure out what's really going on with
> this unexpected phy_power_off() call. Do you think you could
> regression-test the patch attached?
> 

I tested the patch. But it fails ufs_qcom_power_up_sequence() if PHY was already
powered on:

[   31.513321] qcom-qmp-ufs-phy 1d87000.phy: phy initialization timed-out
[   31.513335] ufshcd-qcom 1d84000.ufshc: Failed to calibrate PHY: -110
[   31.565273] ufshcd-qcom 1d84000.ufshc: Enabling the controller failed

Funny thing is, it didn't affect the functionality since the UFS core retries
ufshcd_hba_enable() and in the error path of ufs_qcom_power_up_sequence(),
phy_power_off() gets called and that causes the next try to succeed. So it is
evident that, if PHY was already powered ON, it should be powered off before
ufs_qcom_phy_power_on(). And due to the UFS driver design,
ufs_qcom_power_up_sequence() can get called multiple times. So we cannot just
remove phy_power_off().

Below diff on top of your patch fixes the issue:

```
diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index ed067247d72a..2c9fe03f349e 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -567,6 +567,8 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
        if (ret)
                return ret;
 
+       ufs_qcom_phy_power_off(host);
+
        ret = ufs_qcom_phy_set_gear(host, mode);
        if (ret) {
                dev_err(hba->dev, "%s: phy_set_mode_ext() failed, ret = %d\n",
```

- Mani

-- 
மணிவண்ணன் சதாசிவம்

