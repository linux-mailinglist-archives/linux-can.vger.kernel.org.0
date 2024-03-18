Return-Path: <linux-can+bounces-400-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5A487E7A5
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 11:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3A71F22511
	for <lists+linux-can@lfdr.de>; Mon, 18 Mar 2024 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E353924B26;
	Mon, 18 Mar 2024 10:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="E+fSyku1";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ZI1+Ox2b"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35E2E644
	for <linux-can@vger.kernel.org>; Mon, 18 Mar 2024 10:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.162
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758841; cv=pass; b=Vi1GB2tyIrTIHNThIfCJALn3uKmcwVqafioA14NaWbGEkNBeEywHenGmXkuhrx3GaQIf4w0TboQIrldbcNK1rdZYMskhC3D1leOoIGFrMUdgV+lWDoMyHb3XfiEWEz3pN0E98sMwTDrWUDNfhaLgZR17o11PMwfcHqTyFxYoyTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758841; c=relaxed/simple;
	bh=RZ1kZA1UuHk68vpc5FOPfWSGAIaVAUad5si1Me1O8Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXNLl9LbScznxvbhBflwStomHsJcxpI/Kj6PkUOPB/tA0jq1JeQbj69Pd+aqN9pT6cYWo8njuSFZjb8IlOqBDhrcZ99/JqDJeG/qa37xw/aQACQK+1zdyZChaTMsVGEzLUtNNHe4rwkMRZ7I/Wux8bg/5F2N5nMRuoUbSK9Plns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=E+fSyku1; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ZI1+Ox2b; arc=pass smtp.client-ip=81.169.146.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1710758829; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Kg6cTuHF41nwP9aGvNbDa2mvI6+7G2Je3BpSCE7mJTebOw/mbkoecbwbXnDdo3ZNer
    10Rr3x8Q0R2B1fMLpDtaaZ7wrgt54LSuzTepstPp94Lr7AzGGkSdJjnohkFVcUcvDTLv
    rnoQbPW12VuLBpico6qpCiGwI3fxVRRBbW3i/LgHJVmWjCMpDOrf5auVnLCUpKFkdBAK
    Pe9Vkn1l5s0owSezyKslQLcXSYK4dIYIV2gqXta1fpb+2NRlh4n06mh7ivo2ryvBMjQS
    mOMAfCuJag0bAhoih4j5a1BLR9HHcNc1LD9RgLQJUVZSc3G1s6j3ZE73Lg5wZLkYFsig
    D8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=49sTKYEAcSa6RLnINJ81WIKjUWN4TsR5fU4B90yTwAA=;
    b=I1lJW5KQ8aK784PspykJGwcU0tsF9ucKvd1KQwaENAGuPz5ynCOqiG0g8Ujmu4lx5W
    6S4KgXGoz4QsGTqNTE0D61qSmH5TECXhmWsA69ZUNPAhi8YaLRNWxjZPtIWOKQ0U1++/
    4YxOGyS/+TDXqoUH8ERaNrAJhRLjCrFIcdwa6AA8jVjIT7MMqwMYwF2J2uCXi2FzlfDY
    apsARCWMw0UBM9EJfLltwGar8E56gaDSoOIiTfJVAIUD1/gML344nQF2awpUcgVwbya3
    E8q5a6evBg0Bhbmpe0oFc9oUdn78KuCgyEQALpV1yYBefivTTW3P+4vpWfW2Etl0lm14
    nQTA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=49sTKYEAcSa6RLnINJ81WIKjUWN4TsR5fU4B90yTwAA=;
    b=E+fSyku1nXt2+nHIpQ34j0n3J9m8P0h993aUfCnLWfa3N68sVXAm48kCmG1UkHBHdD
    XDm4DwJ74o6bThA1anolfUpTv+q2nDDhatWYjutIg6jhQEu6FveTDwqYumwtLLDeOHyT
    gaowedHOrwpfHj+xeInYk0dbk6bnFLYGXhp6ZojtZ8jOP61fNfLKS9FCqpQEApFda9tY
    6YHXoxze8dmvw0STo5GEmjM2CxVxUsgxZZ5c0xz9jQM8T1IYBV5F7aHr3YwiicGB0HUp
    EcaS0xKdxuRT9DOy/+VhDTzdCCwqkCIRmr5+q1hFjFFNfzDi7N7r2yVHWxYs9TwnIxyV
    tX7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1710758829;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=49sTKYEAcSa6RLnINJ81WIKjUWN4TsR5fU4B90yTwAA=;
    b=ZI1+Ox2byoV7hlAc/S9Gdj84U35mAmD5x9yKQkRCaNuXedehaOtkSw8uMXbrT8W1kA
    pz0cBb22d015wYuGvICw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjGrp7owjzFK3JbFk1mS/xvEBL7X5sbo3VYpXsQi7qV3YmVcfhbrd"
Received: from lenov17.lan
    by smtp.strato.de (RZmta 50.2.2 AUTH)
    with ESMTPSA id K0cc6102IAl98Ts
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 18 Mar 2024 11:47:09 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Guy Harris <gharris@sonic.net>
Cc: wireshark-dev@wireshark.org,
	linux-can@vger.kernel.org,
	Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 4/4] socketcan: update CAN CiA 611-1 definitions
Date: Mon, 18 Mar 2024 11:46:43 +0100
Message-ID: <20240318104643.24098-5-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318104643.24098-1-socketcan@hartkopp.net>
References: <20240318104643.24098-1-socketcan@hartkopp.net>
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
 epan/dissectors/packet-socketcan.c | 13 ++++++++-----
 epan/dissectors/packet-socketcan.h | 17 ++++++++++-------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/epan/dissectors/packet-socketcan.c b/epan/dissectors/packet-socketcan.c
index 4ca0479f79..09b5f687fc 100644
--- a/epan/dissectors/packet-socketcan.c
+++ b/epan/dissectors/packet-socketcan.c
@@ -171,15 +171,18 @@ static const value_string can_err_trx_canl_vals[] = {
 
 static const value_string canxl_sdu_type_vals[] = {
     { 0x00, "Reserved" },
     { CANXL_SDU_TYPE_CONTENT_BASED_ADDRESSING, "Content-based Addressing" },
     { 0x02, "Reserved for future use" },
-    { CANXL_SDU_TYPE_CLASSICAL_CAN_AND_CAN_FD_MAPPED_TUNNELING, "Classical CAN/CAN FD mapped tunneling" },
-    { CANXL_SDU_TYPE_IEEE_802_3_MAC_FRAME_TUNNELLING, "IEEE 802.3 (MAC frame) tunneling" },
-    { CANXL_SDU_TYPE_IEEE_802_3_MAC_FRAME_MAPPED_TUNNELING, "IEEE 802.3 (MAC frame) mapped tunneling" },
-    { CANXL_SDU_TYPE_CLASSICAL_CAN_MAPPED_TUNNELING, "Classical CAN mapped tunneling" },
-    { CANXL_SDU_TYPE_CAN_FD_MAPPED_TUNNELING, "CAN FD mapped tunneling" },
+    { CANXL_SDU_TYPE_CAN_CC_CAN_FD, "CAN CC/CAN FD" },
+    { CANXL_SDU_TYPE_IEEE_802_3, "IEEE 802.3 (MAC frame)" },
+    { CANXL_SDU_TYPE_IEEE_802_3_EXTENDED, "IEEE 802.3 (MAC frame) extended" },
+    { CANXL_SDU_TYPE_CAN_CC, "CAN CC" },
+    { CANXL_SDU_TYPE_CAN_FD, "CAN FD" },
+    { CANXL_SDU_TYPE_CIA_611_2, "CiA 611-2 (Multi-PDU)" },
+    { CANXL_SDU_TYPE_AUTOSAR_MPDU, "AUTOSAR Multi-PDU" },
+    { CANXL_SDU_TYPE_CIA_613_2, "CiA 613-2 (CANsec key agreement protocol" },
     { 0xFF, "Reserved" },
     { 0, NULL }
 };
 
 /********* UATs *********/
diff --git a/epan/dissectors/packet-socketcan.h b/epan/dissectors/packet-socketcan.h
index f82fa5e20b..87f51b2328 100644
--- a/epan/dissectors/packet-socketcan.h
+++ b/epan/dissectors/packet-socketcan.h
@@ -123,18 +123,21 @@ typedef struct can_info {
 
 gboolean socketcan_call_subdissectors(tvbuff_t *tvb, packet_info *pinfo, proto_tree *tree, struct can_info *can_info, const gboolean use_heuristics_first);
 gboolean socketcan_set_source_and_destination_columns(packet_info* pinfo, can_info_t *caninfo);
 
 /*
- * CAN XL SDU types.
+ * CAN XL SDU types from CAN CiA 611-1
  */
-#define CANXL_SDU_TYPE_CONTENT_BASED_ADDRESSING	                 0x01
-#define CANXL_SDU_TYPE_CLASSICAL_CAN_AND_CAN_FD_MAPPED_TUNNELING 0x03
-#define CANXL_SDU_TYPE_IEEE_802_3_MAC_FRAME_TUNNELLING           0x04
-#define CANXL_SDU_TYPE_IEEE_802_3_MAC_FRAME_MAPPED_TUNNELING     0x05
-#define CANXL_SDU_TYPE_CLASSICAL_CAN_MAPPED_TUNNELING            0x06
-#define CANXL_SDU_TYPE_CAN_FD_MAPPED_TUNNELING                   0x07
+#define CANXL_SDU_TYPE_CONTENT_BASED_ADDRESSING 0x01
+#define CANXL_SDU_TYPE_CAN_CC_CAN_FD            0x03
+#define CANXL_SDU_TYPE_IEEE_802_3               0x04
+#define CANXL_SDU_TYPE_IEEE_802_3_EXTENDED      0x05
+#define CANXL_SDU_TYPE_CAN_CC                   0x06
+#define CANXL_SDU_TYPE_CAN_FD                   0x07
+#define CANXL_SDU_TYPE_CIA_611_2                0x08
+#define CANXL_SDU_TYPE_AUTOSAR_MPDU             0x09
+#define CANXL_SDU_TYPE_CIA_613_2                0x0A
 
 #endif /* __PACKET_SOCKETCAN_H__ */
 
 /*
  * Editor modelines  -  https://www.wireshark.org/tools/modelines.html
-- 
2.43.0


