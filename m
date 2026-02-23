Return-Path: <linux-can+bounces-6615-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJvKLmGDnGlwIwQAu9opvQ
	(envelope-from <linux-can+bounces-6615-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 17:42:09 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5536A17A00C
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 17:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4020630398E0
	for <lists+linux-can@lfdr.de>; Mon, 23 Feb 2026 16:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2DE318EE4;
	Mon, 23 Feb 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xb5vwaB5"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1E314A9E;
	Mon, 23 Feb 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864781; cv=none; b=Oo5X7XuRX1cnpj9mILgOJOxEQEOXWofqeGATWyNW7uzexEA2+mDVEphzQq9gUUvdfapj/SxRy2+HY15HeAQ5s/+DZYn0vCANULMpw4VAs3ahJegbIdFQswZYMzHxi+JnPaHFO2ETLTg3hs5V/s8oH4UcpD1ZXBB+3f3wNxfmjWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864781; c=relaxed/simple;
	bh=o41DBXCI/qgjCzPzhjJ/+ySlhZRDeSbMo3c05x7nLNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yc9DJ3eF2IghR5zM3nlWuby6GD19kfBjqngUfd/Z8MWk4YqlqTl7psjFIOpjYWnpPb7WsgIMJCaE96zm1HgjLNIFI8pM5de8jQwHK4yej/myVZtJOOvPSmwORGUiU2LApRloZB8tIL/6TBbB5N6jzwQ/+0Q1zaCG67PYNIPiGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xb5vwaB5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C25C19421;
	Mon, 23 Feb 2026 16:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771864781;
	bh=o41DBXCI/qgjCzPzhjJ/+ySlhZRDeSbMo3c05x7nLNw=;
	h=From:To:Cc:Subject:Date:From;
	b=Xb5vwaB5lMFWcEXJ4PemesBENYft5qQjO0j8UBACeSiAuCSHGhpBG9R2sfuD5P6Va
	 fPSXyfrjbDIu+3EP2KcJKzkIKbpU2Ifzl30AWgs3wUxGVK2IRiQrIzX4cAHh1mQT2o
	 0eBTjaPDE/9ex87u5SPRLh54RJhgyvJpEb23FHkw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-can@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	stable <stable@kernel.org>
Subject: [PATCH] can: usb: etas_es58x: correctly anchor the urb in the read bulk callback
Date: Mon, 23 Feb 2026 17:39:20 +0100
Message-ID: <2026022320-poser-stiffly-9d84@gregkh>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 41
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=o41DBXCI/qgjCzPzhjJ/+ySlhZRDeSbMo3c05x7nLNw=; b=owGbwMvMwCRo6H6F97bub03G02pJDJlzmnbsmf/+omiwi5ro+V9X33ck6B7xuPV85hWnbZ9q9 hxxmui6qSOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAmEnubYcGNvXv+mUwWEuh6 cWGzdYvvL6U52Y0MC86F2l1suPDv9YmJTi/0Fsk2W9To3gUA
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-6615-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 5536A17A00C
X-Rspamd-Action: no action

When submitting an urb, that is using the anchor pattern, it needs to be
anchored before submitting it otherwise it could be leaked if
usb_kill_anchored_urbs() is called.  This logic is correctly done
elsewhere in the driver, except in the read bulk callback so do that
here also.

Cc: Vincent Mailhol <mailhol@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index 2d248deb69dc..b259f6109808 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -1461,12 +1461,18 @@ static void es58x_read_bulk_callback(struct urb *urb)
 	}
 
  resubmit_urb:
+	usb_anchor_urb(urb, &es58x_dev->rx_urbs);
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (!ret)
+		return;
+
+	usb_unanchor_urb(urb);
+
 	if (ret == -ENODEV) {
 		for (i = 0; i < es58x_dev->num_can_ch; i++)
 			if (es58x_dev->netdev[i])
 				netif_device_detach(es58x_dev->netdev[i]);
-	} else if (ret)
+	} else
 		dev_err_ratelimited(dev,
 				    "Failed resubmitting read bulk urb: %pe\n",
 				    ERR_PTR(ret));
-- 
2.53.0


