Return-Path: <linux-can+bounces-2859-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501ADA3BCE8
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 12:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCA83B72AE
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E171DFD8B;
	Wed, 19 Feb 2025 11:34:04 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746FA1D8DE1
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964844; cv=none; b=KPtddJr7/ABGXAbL7k003Ogq2MRi/OPCNxMyz03cHwxm96DzWYqcxiRBSaudBOBDPc159x0DTfn1zegcDiRq7JlaCCT+tj6XUhU/7u2cb/Hy9+7IFIWa7Ob1y0BEQK166YsvdH0R2PVY5Fc6jnxrsRAqgi4mCMCgSOumGcViZLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964844; c=relaxed/simple;
	bh=r/9dBThBDE3hJ4zD3E3JKyC3/wfCmHieBlpH7qvJQ0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFndy8wQFdPJgG1hyBMu51y7pLupBSCthkm/EFsE+mT+Q2By6cNC7LNbxzRKLIptxcAtqk2lyHuD85iPsPfuPNymSuZtJLPCgpc0Hv/u2KwaQYDQd5SFgcbSvjrJRJ3UEtCHht1qCSbr31dwP3X1Q4lzAGJHamMDWAdWFz54icQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL1-0001UG-QJ
	for linux-can@vger.kernel.org; Wed, 19 Feb 2025 12:33:59 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL1-001kyy-0d
	for linux-can@vger.kernel.org;
	Wed, 19 Feb 2025 12:33:59 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D0CB63C6903
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:33:58 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 3A65D3C68DA;
	Wed, 19 Feb 2025 11:33:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id ff49451b;
	Wed, 19 Feb 2025 11:33:56 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/12] can: c_can: Use syscon_regmap_lookup_by_phandle_args
Date: Wed, 19 Feb 2025 12:21:09 +0100
Message-ID: <20250219113354.529611-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219113354.529611-1-mkl@pengutronix.de>
References: <20250219113354.529611-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
syscon_regmap_lookup_by_phandle() combined with getting the syscon
argument.  Except simpler code this annotates within one line that given
phandle has arguments, so grepping for code would be easier.

There is also no real benefit in printing errors on missing syscon
argument, because this is done just too late: runtime check on
static/build-time data.  Dtschema and Devicetree bindings offer the
static/build-time check for this already.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20250212-syscon-phandle-args-can-v2-4-ac9a1253396b@linaro.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/c_can/c_can_platform.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
index 1acceb097c17..19c86b94a40e 100644
--- a/drivers/net/can/c_can/c_can_platform.c
+++ b/drivers/net/can/c_can/c_can_platform.c
@@ -317,30 +317,21 @@ static int c_can_plat_probe(struct platform_device *pdev)
 		 * platforms. Only supported with DT boot.
 		 */
 		if (np && of_property_present(np, "syscon-raminit")) {
+			unsigned int args[2];
 			u32 id;
 			struct c_can_raminit *raminit = &priv->raminit_sys;
 
 			ret = -EINVAL;
-			raminit->syscon = syscon_regmap_lookup_by_phandle(np,
-									  "syscon-raminit");
+			raminit->syscon = syscon_regmap_lookup_by_phandle_args(np,
+									       "syscon-raminit",
+									       2, args);
 			if (IS_ERR(raminit->syscon)) {
 				ret = PTR_ERR(raminit->syscon);
 				goto exit_free_device;
 			}
 
-			if (of_property_read_u32_index(np, "syscon-raminit", 1,
-						       &raminit->reg)) {
-				dev_err(&pdev->dev,
-					"couldn't get the RAMINIT reg. offset!\n");
-				goto exit_free_device;
-			}
-
-			if (of_property_read_u32_index(np, "syscon-raminit", 2,
-						       &id)) {
-				dev_err(&pdev->dev,
-					"couldn't get the CAN instance ID\n");
-				goto exit_free_device;
-			}
+			raminit->reg = args[0];
+			id = args[1];
 
 			if (id >= drvdata->raminit_num) {
 				dev_err(&pdev->dev,
-- 
2.47.2



