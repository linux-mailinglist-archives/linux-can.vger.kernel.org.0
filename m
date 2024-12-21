Return-Path: <linux-can+bounces-2473-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F499F9E26
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 04:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CAB188F8A2
	for <lists+linux-can@lfdr.de>; Sat, 21 Dec 2024 03:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3176C1DC993;
	Sat, 21 Dec 2024 03:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="mafBkgDc"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1A12A1CA;
	Sat, 21 Dec 2024 03:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734753269; cv=none; b=XDew62XNIPeuL7eJxiMoG8xmmBkq73Z+Md20U6j5t803L9bBqhAeB0ZlBDN2M4zLjwg9KGc1uobXBC+ymNBfr0UYakWxZshpxFwne7kZk6eh3u8cQXFgdxzerM01DDoRYtxMGXQZf2eNAtlsE9E9Ni4bRxlHF9qY6xOdPdSUi54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734753269; c=relaxed/simple;
	bh=rMrFuj1mcqxNBj4ULL9b39T4RNEENvGonnQaT1vMmXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KZd9U9p202RTKIT38lr7y8XcJ1XWHSSNA05Jn0SIgc9/5sgyrs4xU9FmyQCXbp6/RrYrsdoNNMsxXodEYStBFF9kx98ATXWtYaia9zrarrWTCcL41LtHTK5gNyEJD/VJViWGpnLjISHCbvOpTCA2kDAWqSDjOh8bQB36lyxEjvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=mafBkgDc; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734753267; x=1766289267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rMrFuj1mcqxNBj4ULL9b39T4RNEENvGonnQaT1vMmXk=;
  b=mafBkgDcksU9bc0Il0Cc78hRfi1H1+bluQ6UlnWI/GM/7X6TQMX+VKhd
   q1DXTh/bgs0nJPwGkHWvoNaBB71PkPWo5ZWLHIS5pTY0m43kqCHg8GJ12
   jvLtbLoRx99Z2b4CCEBg6e/A0n8gqjNFo70ak2y72RBodkA1Is/nNpeUr
   U=;
X-CSE-ConnectionGUID: omllOnv0TmKkC/zgcWQkdA==
X-CSE-MsgGUID: /EX/0BAMSFS4br3J5rV1Xg==
X-IronPort-AV: E=Sophos;i="6.12,252,1728943200"; 
   d="scan'208";a="28282875"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 21 Dec 2024 04:54:24 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 3FE5A24CA;
	Sat, 21 Dec 2024 04:54:23 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-can@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 1/3] drivers/firmware/broadcom, ethernet/marvell: Remove unused values
Date: Sat, 21 Dec 2024 04:44:15 +0100
Message-ID: <20241221035352.1020228-2-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221035352.1020228-1-ariel.otilibili-anieli@eurecom.fr>
References: <20241221035352.1020228-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coverity-IDs: 1487817, 1561102
Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
---
 drivers/firmware/broadcom/tee_bnxt_fw.c                   | 2 --
 drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index 40e3183a3d11..e0ea4ddb9a74 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -143,8 +143,6 @@ int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size)
 	prepare_args(TA_CMD_BNXT_COPY_COREDUMP, &arg, param);
 
 	while (rbytes)  {
-		nbytes = rbytes;
-
 		nbytes = min_t(u32, rbytes, param[0].u.memref.size);
 
 		/* Fill additional invoke cmd params */
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
index 6cc7a78968fc..0584528485e6 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/cn10k_macsec.c
@@ -329,11 +329,9 @@ static int cn10k_mcs_write_rx_flowid(struct otx2_nic *pfvf,
 	mac_da = ether_addr_to_u64(secy->netdev->dev_addr);
 
 	req->data[0] = FIELD_PREP(MCS_TCAM0_MAC_DA_MASK, mac_da);
-	req->mask[0] = ~0ULL;
 	req->mask[0] = ~MCS_TCAM0_MAC_DA_MASK;
 
 	req->data[1] = FIELD_PREP(MCS_TCAM1_ETYPE_MASK, ETH_P_MACSEC);
-	req->mask[1] = ~0ULL;
 	req->mask[1] &= ~MCS_TCAM1_ETYPE_MASK;
 
 	req->mask[2] = ~0ULL;
-- 
2.47.1


