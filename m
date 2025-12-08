Return-Path: <linux-can+bounces-5827-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B566CADAB0
	for <lists+linux-can@lfdr.de>; Mon, 08 Dec 2025 16:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2125302EA5E
	for <lists+linux-can@lfdr.de>; Mon,  8 Dec 2025 15:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41BA2E1747;
	Mon,  8 Dec 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JlYi4Std"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD60D2D47F1
	for <linux-can@vger.kernel.org>; Mon,  8 Dec 2025 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209031; cv=none; b=VxrHb97wA/30GqzJOr72k3ZMb4cYIUMs/D8imk7amx2auw5tehvndpTg9QrZS6J4PYg5AQ3Ijy5UOGdKkvGWLdKxeiMF2PLb/bXdLLt813PAWVmdKNs3/flye4FFKutd9R2DDoFL4qdNKUL2+KqipOuID+QWnd7g2itqnx8v6KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209031; c=relaxed/simple;
	bh=lfdWmhaZJTMON4teAatnLxOF0XN73G5Ei5TmlUHmFeg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/Qxq/6urwyMKfXkTmKlDazy2xO3K8toKfBDCsxJcfYckJcgHltnfQ7Q8NvG11eGZ/Nb7LMov0A5LqMn99CCQOA+pmKqT16s7wfQw4knUec8JuflTaiojPpskyhcJKOGPcy9rsH9K70onRE/wjQCwZZyOjTcq1GzHkjUTUE99GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JlYi4Std; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso34816165e9.1
        for <linux-can@vger.kernel.org>; Mon, 08 Dec 2025 07:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765209028; x=1765813828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9vxAtmbsc9sfd8WNWIA8+tguwKaRWIk3O57bGcLZew=;
        b=JlYi4StdoX+cEhgdpGBWC5noHgn8GD9pKgTZ+wIoiG4SZ8MVL58J+TMRdh//HRaTrz
         V7FOCWLPxXwRs0bEe3C7KCQYvD4ScXzN/fwY9ShVPmGddGTT98nbZFWlOhM43uHqM3kT
         UhdJ6zoqHi9k67F8nOcubu3Xdvxs0IOiLoT9ReQrtuq6CnmGJEOMrwiIbvkEVOEzlHxk
         MANh+Nq2TFdyB+EpNCyXCbJPHZ5X6SYyX9OJtyRh1dU9WrCnaa0GY8Mq01Bj1D77X1VH
         Ux9QjXpAJx/ANC81dvGvU9pCV9TcngY68397sAw57jdAXTrIZPZjk/RkJy4ZjT9LQ8uq
         cVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765209028; x=1765813828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E9vxAtmbsc9sfd8WNWIA8+tguwKaRWIk3O57bGcLZew=;
        b=rdcN47vIfv+v9OvDRplTk56CtAU4IMbN7XLqEG3bkQem3YrbtrZJ6jpFLI3OF686ld
         JUmCGEsKDRlqug12fBh8H6eUFFS26eHGNIqY5q4pRisUrWTR/UK69sPvZ7ilqRiHmb7K
         kZA57+Mf6WaaCBnJKWrDWYiweHIF2S/W22QfujdSO190vqS/+ZBeGymHpAhLo/WGEaBK
         yU9siFusU1f42hgHszU++RIECQ0woDtLMs8vL5BA2Kyzy6SwBBWhLHCwHwr9WEFvEOxW
         1RK3+0RarxFMwq+OJdlCKLbixuHhJhrkniRCQtn3ckS40DAg1Er/S9APrv1HDJX99ud2
         Z29g==
X-Gm-Message-State: AOJu0Yx999N3u6VprOpV8Y2fB3tIoRpOjwt3JQXXAqu97rdW5jlDmCSM
	Hv7x0iR/ExCI5gG8HRf6dWDTpc3Y3qpkLUKdu9ln53wPv465HdxC4ohs
X-Gm-Gg: ASbGncuM9eW4cFZWLeDSIitnRV2PprWDajQU/A/PrxZyx+UvZKS4QhFNlBXBJTnBEPj
	5XVfi/u/dYVcOVesDF8auyalT1jcTzVJU7VWwQCWKTrcWo0Aj6DHliUH5K1L7auSBiQn7b1tGyj
	HsAeikajsVP3QhGBPMoG+v3FlpjKE7KqE3mlsbblf3/l7xxEz2aamlzjxR08641a6sy/ySoZpDx
	tFnuRDnLywpQTx79T1rl1S3bYQ74Bfa25zoG9hkciqPgVST4sGHsB3WE0axaeBbPb2brjmTzMRL
	9PtLItIBTPLM+QNe90BVGIqpHcgM3I++wX46aVFyt87KOp8AzzPxhucVebjP2K1tXAN0VCphAvX
	0R3LwtQ21DnIBKXz2gqtLsC7h7SLMC2Ur/Nl1eDmB+I9zfvweA2EnagomIb0swZ3QB0UTWvyRFj
	kdpVWFj+6zByC/EhuPaHkCrV0pRxv9Bm/M0w==
X-Google-Smtp-Source: AGHT+IFljt5YHUzlULBDoRx85WjVasSaNXrLqrRgyJpEfzkXWUGKm/KRhMnTMpRbYvSGWx2zxHRZAw==
X-Received: by 2002:a05:600c:c3cb:20b0:47a:7aa0:175a with SMTP id 5b1f17b1804b1-47a7aa0175emr11840195e9.26.1765209028120;
        Mon, 08 Dec 2025 07:50:28 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:9aa6:8a23:82c5:2b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b150878sm147717845e9.3.2025.12.08.07.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:50:27 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document TI TCAN1046
Date: Mon,  8 Dec 2025 15:50:18 +0000
Message-ID: <20251208155019.136076-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251208155019.136076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251208155019.136076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document the TI TCAN1046 automotive CAN transceiver. The TCAN1046
provides dual high-speed CAN channels and includes STB1/2 control
lines.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index c686d06f5f56..c53c4f703102 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -23,6 +23,7 @@ properties:
       - enum:
           - ti,tcan1042
           - ti,tcan1043
+          - ti,tcan1046
           - nxp,tja1048
           - nxp,tja1051
           - nxp,tja1057
@@ -84,7 +85,9 @@ allOf:
       properties:
         compatible:
           contains:
-            const: nxp,tja1048
+            enum:
+              - ti,tcan1046
+              - nxp,tja1048
     then:
       properties:
         '#phy-cells':
-- 
2.52.0


