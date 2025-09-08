Return-Path: <linux-can+bounces-4518-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63765B48CEB
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 14:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F0A175427
	for <lists+linux-can@lfdr.de>; Mon,  8 Sep 2025 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2609D2FCBE1;
	Mon,  8 Sep 2025 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emtoAOZt"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D832F3C1A;
	Mon,  8 Sep 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333388; cv=none; b=qcNKZjumiDygF9Pf5SoqhjaeUS3KVFxFWFwcKLr0+Ci0qDhf3ECvK5FHmQmwhDDVVJePKMXAew6z0GvBDV0P+SSG0a2SwRh74Q6BepXmRIL0RPvH7fhRvQu6SbensAy2bpJ7Uf/8xeMWZHj+C8AiB6nkBlzC5hdPXw2AmrEL/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333388; c=relaxed/simple;
	bh=H+xjditBxyX2hQRMgA6E4NAbCPYslBQUnZwDsyA/O/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8/+aQcrhEAK1PclIgCqRNLKkm2X5ntAliO3A3VmwUBdBwyaaCaxAhXch75Myx+rUgl5IpbK9KOcm9GnczCzSSCSv6BOmhDVp3viTi5fSxa73JwcBXHhLfr6YQS0fTx6QUX1rv7EZ/70NRXGZRRJCC/NrETgphH+YNsp9mrLZhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emtoAOZt; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3d3ff4a4d6fso2637362f8f.0;
        Mon, 08 Sep 2025 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757333384; x=1757938184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ik+xsJQUxPVH2IFlCRiMPMQeH7RbsU5tb884vTQlh7w=;
        b=emtoAOZtQTC1sM10L6cHnXZkxXdaUw2nLcrwwOrL0GBXkKjED6UOxxvtorHsKG0ZaH
         4LZa9RdVpyLj4ygOgKaTB057UugCdKzjejmqHsUQGQDRhgD8C7BEwjyLOV0mMMhyWWeE
         GN3AmE33gNX3tKJqpiAm01LDheJSdxTxwjRVrk59Qs45EEUvZi4Z8rK6tZGpGc/+B3uW
         uTp5MvA3rz+DZHo+2+y8d7MyFMxLF1ncPg9+fs0d8pQikhHhRCsN09hPMKVfROqRhmW6
         jAZYgRWZVKo8eYHsdo7ImT6wAtg90Lour0b/SC26MoRLAbXyRKXxgc4r7bK49lKu34+1
         zP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333384; x=1757938184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ik+xsJQUxPVH2IFlCRiMPMQeH7RbsU5tb884vTQlh7w=;
        b=D/hht+9hEiwKyoXe6f7WvajtO2Y29bpLY0FdiTj/RpJ0f+5LXexlV5dnu20FrDNm4h
         4a5R5YqlDt+RMUHMZDwa6eLYwLU0hv27fZXmU51xBo5Xykzcala7GTMkDSZfj2gOrtwN
         r1a09NpdT8A06hB2YaX4QkkdVAF/x3vhsnjkJUsjKi4EcygNMi9l06K5g7B10l+P2no/
         3acouNkO3DJQaKoCVtEu+ZTMEe7u81YAjSwq61lDPRtkF7jk1AQim7pP8FzpkZzlDEy4
         FNOnnCTwNmt4yAVfxBxXtpkcvlpZ3Dlw1o7DMHF330mc1soYk4jXsEkcx9C5MWYc3F3W
         LzoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbuCIMp590HcwZDkGXTyiy1456/3B97XZqZtMn5QcEUf+TxOGKLts8Z+FMSlpVEHPmv4zwBooF5VA=@vger.kernel.org, AJvYcCWQO6hmtuzqKE/mLwRvXacyK1SaV1Q6FwSjNOg1/KzbrWASBzTr2ZH+kv0kv3GULQU1cvuJFv79IEM36zW8@vger.kernel.org, AJvYcCWqu3HlK3xQxMBKLfF5ON3LQctUbz1nNg0eV0dFghl6ZoSFjw5jsGPw3h7OWJS46Eqv3Pg/Ce1H4Zonocx6qPJ/T00=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN5oFvd2RI15aoBtXC4vqRe2WWgN26ws9nTWJG8bYjF+IUemMP
	CNzX73cvwtA0Ugh3zgNpVlSxnOKK9wAY7g3txY5pt+Yq+4uHZO4BUsOR/c/kmg==
X-Gm-Gg: ASbGncvgHVOA/EmoCpZHDnG68PZlonk2GS7opQVTQAVHmX1btGOGrR6RT8kQfeJZcij
	PTK8qrjA5fkPOqUsQBf+P+V3QpBe4biK1tTlUj0QrtS8FL+rvUjShyA1Jg9WnrXRzlwnsWbuC81
	neyG3V7snsKs5ULfZfhvJkbEqZ2tSTE6T1ajYaZjir/k/SoSvX9IU6S53TKHH103eijccpfFFOe
	0BB+ltGimVVNpuJ02dfxV/Z6nVJKBtjS13X2LbNtJ2ElSQPA37EZJ4C/lIzm5q/jN4G12GD+jl5
	b8xlnhZTs0+qQpRKN3pPceQuvKBAy2mKHg2z/HUeaTuWCLnIXQezO1R1p9yNWyX/umEqJMxyLy1
	dmLdGIyi/kDcLtE8mkI1Mene5PyFvlxxxEheU4KYERAjqIZtvIFafF3IVV4DO8n6co2vR3CXNUo
	dMDHyeM8zmlcbr
X-Google-Smtp-Source: AGHT+IGpW8ESARyCfwP9h6v7ngjtx+uxf0PWHjyKJ9f1PknuFkdZSpc/6I5FV0Y5AQUtYUMJum6N7A==
X-Received: by 2002:a05:6000:2906:b0:3dc:45be:4a7f with SMTP id ffacd0b85a97d-3e643b18ccfmr3946799f8f.57.1757333384356;
        Mon, 08 Sep 2025 05:09:44 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e543e9f444sm9646415f8f.60.2025.09.08.05.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 05:09:43 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 2/4] can: rcar_canfd: Update RCANFD_CFG_* macros
Date: Mon,  8 Sep 2025 13:09:31 +0100
Message-ID: <20250908120940.147196-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908120940.147196-1-biju.das.jz@bp.renesas.com>
References: <20250908120940.147196-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Update RCANFD_CFG_* macros to give a meaning to the magic number using
GENMASK macro and extract the values using FIELD_PREP macro.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Added Rb tag from Geert.
 * Dropped _MASK suffix from RCANFD_CFG_* macros.
v1->v2:
 * Moved from patch#4 to patch#2.
 * Updated commit header and description.
 * Kept RCANFD_CFG* macro definitions to give a meaning to the magic
   number using GENMASK macro and used FIELD_PREP to extract value.
---
 drivers/net/can/rcar/rcar_canfd.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 4185fc5b4a70..8d0d0825cb54 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -103,10 +103,10 @@
 /* Channel register bits */
 
 /* RSCFDnCmCFG - Classical CAN only */
-#define RCANFD_CFG_SJW(x)		(((x) & 0x3) << 24)
-#define RCANFD_CFG_TSEG2(x)		(((x) & 0x7) << 20)
-#define RCANFD_CFG_TSEG1(x)		(((x) & 0xf) << 16)
-#define RCANFD_CFG_BRP(x)		(((x) & 0x3ff) << 0)
+#define RCANFD_CFG_SJW		GENMASK(25, 24)
+#define RCANFD_CFG_TSEG2	GENMASK(22, 20)
+#define RCANFD_CFG_TSEG1	GENMASK(19, 16)
+#define RCANFD_CFG_BRP		GENMASK(9, 0)
 
 /* RSCFDnCFDCmNCFG - CAN FD only */
 #define RCANFD_NCFG_NTSEG2(gpriv, x) \
@@ -1411,8 +1411,8 @@ static void rcar_canfd_set_bittiming(struct net_device *ndev)
 		cfg = (RCANFD_NCFG_NTSEG1(gpriv, tseg1) | RCANFD_NCFG_NBRP(brp) |
 		       RCANFD_NCFG_NSJW(gpriv, sjw) | RCANFD_NCFG_NTSEG2(gpriv, tseg2));
 	} else {
-		cfg = (RCANFD_CFG_TSEG1(tseg1) | RCANFD_CFG_BRP(brp) |
-		       RCANFD_CFG_SJW(sjw) | RCANFD_CFG_TSEG2(tseg2));
+		cfg = FIELD_PREP(RCANFD_CFG_TSEG1, tseg1) | FIELD_PREP(RCANFD_CFG_BRP, brp) |
+		      FIELD_PREP(RCANFD_CFG_SJW, sjw) | FIELD_PREP(RCANFD_CFG_TSEG2, tseg2);
 	}
 
 	rcar_canfd_write(priv->base, RCANFD_CCFG(ch), cfg);
-- 
2.43.0


