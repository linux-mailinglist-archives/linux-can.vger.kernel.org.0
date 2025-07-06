Return-Path: <linux-can+bounces-3949-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E4AFA58C
	for <lists+linux-can@lfdr.de>; Sun,  6 Jul 2025 15:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48FB8189BD72
	for <lists+linux-can@lfdr.de>; Sun,  6 Jul 2025 13:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C675C215F6C;
	Sun,  6 Jul 2025 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="M21xln0B";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="2raDiPTU"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B18E24678F
	for <linux-can@vger.kernel.org>; Sun,  6 Jul 2025 13:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751808997; cv=pass; b=LfRiapY9JLapwIQubnSgyjd1tXPLtXYienZ9al7xyp2mRHdckDVka41z3kXQBQ6SbikM9YkF78VFrI5OMBKaQ3hcuSbfRNiMRUqfolXbzQU0BVCRmBHKoRPuBHbAP69JBWo9eZNx/7jAWrkny/NSIlflaJJZ2xikywsr6qhRkjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751808997; c=relaxed/simple;
	bh=1IK1NlQ8wo3R1ReEiSZAyPFRF9i3hu9a1pZQmTtAxkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FzDzUMZAxbAPZRjWsI0xaY1EZ1Hi15vb6arulHRqp9vvA0KiOnxpvGhiuYcrJc3hVuNWU85e4OIcY0WvbyddFruukbXEFE1jOpirDJNC0XKb/mOB68EM6N+mSONu2lGFhDfCW8X4TEwbph3I7cbVtoMqQVCWXtpWEpKfxDnLqoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=M21xln0B; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=2raDiPTU; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1751808984; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VE9jA7ytEfKhTnWfqo2jCZADRyQlBGjKOBCg28vg2rg7O4xBu5cK4kvg5RvmAWiY1+
    bL3A+tdE+ee2NKL4axlHEmnZK+PQsPg7gjWYLeJgk2B9UZg+/ONEXePqwa66IHTeyLeY
    aJ40EPv/NGj1crWYBGruNo6jRK26QSpZGSShZQ8j8h4XjMfUheRggS79UKC/L0qJf+V6
    PuASlDNKxxsmuAlfKZlXucFBPTGrGtWdoX2YzJ6nwbbwCbMvE0mfVp4LRLdjlCcGavwm
    kQSbz6HIK8n/17h8Nm6ut48IiLm9sREluqSu3admcliGJGx6h8IMctfUWoxscFT9nx/O
    A9tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1751808984;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=9KnyNNZ5N9/YcR1rCi6LnKl/MrIGFom2IXBmZpSj/As=;
    b=FZ2BsqVe2kSiIxC41PDUzLuCajGnbjkUeTRIwH0TmN1DekpfTuceiFkawlSwOdynDt
    m00Ix7piO59eSasRGiEWsQ5n5abUlvMPSlqZWbmlytmHfRWSRykkQUAVNIQ7dg9eLUha
    EumK6B4l7mP2b1lv2n0hOminEJw2ppEH7cOXLWC9RP6PNfuaHBvvXCDDOYLlf0A14y1L
    J4T4osZr5KNPXjmi6/ZqJLLJDGtNH/Irdq6XNYr90uPfoinuiTnQCW1FqgsP4hv1fhSe
    cs36Dd/s/XNFJGfJFWD6waVhj+diTs+5ohmDSYnQFWwTD9hsZPJt01mDf92s+4l/y0MS
    qkCg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1751808984;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=9KnyNNZ5N9/YcR1rCi6LnKl/MrIGFom2IXBmZpSj/As=;
    b=M21xln0B+YQuDBJ+ClTkXAolBzwPhgK3Ul6BR6/CE2g1ZzkKmV9OKV7fxrn88iBofl
    y7bOPfxCYuHKG+Lo1tUNqs+/ybtxXf40juzJDMluD16/Ps90VIyK84XBczX5M5wa8DuW
    iQ/XYX4i4SQhY5kbVozo7+FbtUbZzSHx2FtNJQwnoMemnUaSabHBuEGCRo6HjqicQbHv
    bTalMqu9ZvfhXt8VL9ulj5zXSXgo5n3KMCNzlO+DsDDq9v2pwqI9eenvNhx9JAgrK4bR
    IkXZYpzsESIhZoALbgwNDx0MiAufIWpH1BEgInKO0XcOeQ878rhqfmJtoNaYaWWEJVHc
    tkCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1751808984;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=9KnyNNZ5N9/YcR1rCi6LnKl/MrIGFom2IXBmZpSj/As=;
    b=2raDiPTUThA0BX42dTVUedLpJ2HQZvuLM/B2sxJG+ddnbh2xKBM0/TJ1TpZxLpdd6x
    24CHkZlsUxduaJsH+xDA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K55aa3166DaOK1y
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 6 Jul 2025 15:36:24 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH can-next/b4 2/2] dummyxl: print ctrlmode and PWM values
Date: Sun,  6 Jul 2025 15:35:50 +0200
Message-ID: <20250706133550.47369-2-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250706133550.47369-1-socketcan@hartkopp.net>
References: <20250706133550.47369-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 drivers/net/can/dummyxl.c | 92 +++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/dummyxl.c b/drivers/net/can/dummyxl.c
index c61f27b93e9f..5178fb7c10c4 100644
--- a/drivers/net/can/dummyxl.c
+++ b/drivers/net/can/dummyxl.c
@@ -76,11 +76,11 @@ static const struct can_tdc_const dummyxl_xl_tdc_const = {
 
 static void dummyxl_print_bittiming(struct net_device *dev,
 				    struct can_bittiming *bt)
 {
 	netdev_info(dev, "\tbitrate: %u\n", bt->bitrate);
-	netdev_info(dev, "\tsample_point: %u\n", bt->sample_point);
+	netdev_info(dev, "\tsample_point: 0.%u\n", bt->sample_point);
 	netdev_info(dev, "\ttq: %u\n", bt->tq);
 	netdev_info(dev, "\tprop_seg: %u\n", bt->prop_seg);
 	netdev_info(dev, "\tphase_seg1: %u\n", bt->phase_seg1);
 	netdev_info(dev, "\tphase_seg2: %u\n", bt->phase_seg2);
 	netdev_info(dev, "\tsjw: %u\n", bt->sjw);
@@ -92,48 +92,122 @@ static void dummyxl_print_tdc(struct net_device *dev, struct can_tdc *tdc)
 	netdev_info(dev, "\t\ttdcv: %u\n", tdc->tdcv);
 	netdev_info(dev, "\t\ttdco: %u\n", tdc->tdco);
 	netdev_info(dev, "\t\ttdcf: %u\n", tdc->tdcf);
 }
 
-static void dummyxl_print_config(struct net_device *dev)
+static void dummyxl_print_ctrlmode(struct net_device *dev)
 {
 	struct dummyxl_priv *priv = netdev_priv(dev);
 	struct can_priv *can_priv = &priv->can;
+	char opts[300] = { 0 };
 
 	netdev_info(dev, "CAN control mode/supported : %08X/%08X\n",
 		    can_priv->ctrlmode, can_priv->ctrlmode_supported);
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_LOOPBACK)
+		strcat(opts, " loopback");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_LISTENONLY)
+		strcat(opts, " listen-only");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_3_SAMPLES)
+		strcat(opts, " triple-sampling");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_ONE_SHOT)
+		strcat(opts, " one-shot");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_BERR_REPORTING)
+		strcat(opts, " berr-reporting");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_FD)
+		strcat(opts, " fd");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_PRESUME_ACK)
+		strcat(opts, " presume-ack");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
+		strcat(opts, " fd-non-iso");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_CC_LEN8_DLC)
+		strcat(opts, " cc-len8-dlc");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_TDC_AUTO)
+		strcat(opts, " tdc-mode-auto");
+	else if (can_priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL)
+		strcat(opts, " tdc-mode-manual");
+	else
+		strcat(opts, " tdc-mode-off");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_XL)
+		strcat(opts, " xl");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TDC_AUTO)
+		strcat(opts, " xltdc-mode-auto");
+	else if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL)
+		strcat(opts, " xltdc-mode-manual");
+	else
+		strcat(opts, " xltdc-mode-off");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_XL_RRS)
+		strcat(opts, " xlrrs");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TRX)
+		strcat(opts, " xltrx");
+
+	if (can_priv->ctrlmode & CAN_CTRLMODE_XL_ERR_SIGNAL)
+		strcat(opts, " xlerrsig");
+
+	netdev_info(dev, "Enabled modes:%s\n", opts);
+	netdev_info(dev, " \n");
+}
+
+static void dummyxl_print_config(struct net_device *dev)
+{
+	struct dummyxl_priv *priv = netdev_priv(dev);
+	struct can_priv *can_priv = &priv->can;
+
+	netdev_info(dev, " \n");
+	dummyxl_print_ctrlmode(dev);
+
+	netdev_info(dev, "CAN clock:       %9u Hz\n", priv->can.clock.freq);
+	netdev_info(dev, "CAN max bitrate: %9u BPS\n", priv->can.bitrate_max);
+	netdev_info(dev, " \n");
+
 	netdev_info(dev, "CAN CC nominal bittiming:\n");
 	dummyxl_print_bittiming(dev, &can_priv->bittiming);
-	netdev_info(dev, "\n");
+	netdev_info(dev, " \n");
 
 	if (can_priv->ctrlmode & CAN_CTRLMODE_FD) {
 		netdev_info(dev, "CAN FD databittiming:\n");
 		dummyxl_print_bittiming(dev, &can_priv->fd.data_bittiming);
 		if (can_fd_tdc_is_enabled(can_priv)) {
 			netdev_info(dev, "\tCAN FD TDC:\n");
 			dummyxl_print_tdc(dev, &can_priv->fd.tdc);
 		} else {
 			netdev_info(dev, "\tCAN FD TDC is off\n");
 		}
-	} else {
-		netdev_info(dev, "CAN FD is off\n");
+		netdev_info(dev, " \n");
 	}
-	netdev_info(dev, "\n");
 
 	if (can_priv->ctrlmode & CAN_CTRLMODE_XL) {
 		netdev_info(dev, "CAN XL databittiming:\n");
 		dummyxl_print_bittiming(dev, &can_priv->xl.data_bittiming);
 		if (can_xl_tdc_is_enabled(can_priv)) {
 			netdev_info(dev, "\tCAN XL TDC:\n");
 			dummyxl_print_tdc(dev, &can_priv->xl.tdc);
 		} else {
 			netdev_info(dev, "\tCAN XL TDC is off\n");
 		}
-	} else {
-		netdev_info(dev, "CAN XL is off\n");
+		if (can_priv->ctrlmode & CAN_CTRLMODE_XL_TRX) {
+			struct can_pwm *pwm = &can_priv->pwm;
+			netdev_info(dev, "\tCAN XL PWM:\n");
+			netdev_info(dev, "\t\tpwmo: %u\n", pwm->pwm_offset);
+			netdev_info(dev, "\t\tpwml: %u\n", pwm->pwm_phase_long);
+			netdev_info(dev, "\t\tpwms: %u\n", pwm->pwm_phase_short);
+		}
+		netdev_info(dev, " \n");
 	}
-	netdev_info(dev, "\n");
 }
 
 static int dummyxl_netdev_open(struct net_device *dev)
 {
 	int ret;
-- 
2.47.2


