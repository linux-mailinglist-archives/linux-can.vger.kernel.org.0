Return-Path: <linux-can+bounces-5931-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 967CECDCEFC
	for <lists+linux-can@lfdr.de>; Wed, 24 Dec 2025 18:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 73EFC3011A87
	for <lists+linux-can@lfdr.de>; Wed, 24 Dec 2025 17:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E4031A542;
	Wed, 24 Dec 2025 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9lJFDRY"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC1F2D7DE7
	for <linux-can@vger.kernel.org>; Wed, 24 Dec 2025 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766597613; cv=none; b=oM4pdR+eOF38nRNs6/3DtBOo5jtUyN535a8jLgHn7RaWzn03po7IVTGGcIrS2E81/fHqMO9XdA/KT+aNug/2vYnTstZfMtaxp5FAL/VA0frpZNT/UNcpQBpwuqSeIJZcJOyA3GfB5i39ISqmPz5eWJEdSM8VeBLkCcHY41SwinA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766597613; c=relaxed/simple;
	bh=2cCd22upSW/KmRBE8hQQ25UsubWS3S0H6lX6K/nhVNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+ycEMn+KdUlut88aIM9//V3CgNPD2VGwPQEyhfhZWIGGYGjhZYEW3VSUfO0Qda7rC8DGxYGny+UPp5eV7Ngzt73wM0LhwOPw09LEoTPKqM94Nq5ClxmXVaZx+UrZVz0R3UhGiWVbAWNTxpRKVWyE3vuVpKOPBjuJy3l5dVz5r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9lJFDRY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43277900fb4so133800f8f.1
        for <linux-can@vger.kernel.org>; Wed, 24 Dec 2025 09:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766597610; x=1767202410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jL+U/H2FA4I8JmtU1VFqn2gDXH0xURV9q9TTs1K583U=;
        b=j9lJFDRY6WGfpzoSn1J4eTq8BmqupqbseSS3cq7um55JG00P+F4xAMpwyUpuGZTbHW
         CQUcEcrFiGmSKMzll88YngHR4dAelxF7/Wvoamr5l1LC1mAVjHo7TpyvLwGJk9yu5oZE
         UrWpCv+wo2mWSVqAHxtplisTTtJo68Tp4wVz03vQ2+euyBxRo2HsAS/tFmU6dHm+hYp0
         wFcvPkXz18XgvQaj+IrrKuhaZpaD/pJt5JjK/I3pff6e6L6Eld1lY7L3Mk4O/lCEhu1E
         MF2BxkMBdXTBA7B91U7JzhWjswYmBRlECcuwsIDW2YZt5T8SDz/CVlzCT2/KLdVzA4c1
         Mt0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766597610; x=1767202410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jL+U/H2FA4I8JmtU1VFqn2gDXH0xURV9q9TTs1K583U=;
        b=loVgtMXA0EAmoDV7HYsYJqf7xOhPIBjSJMLJyFKJ7bUWM4QPljjxJNOiKrVDEtIuER
         02D14HJqgrJhr51STBOpPCsO1rvFHI46uwxnn/WoGzEGzQooODKESC5ceNnHvQtgGam6
         aHdYTZLbcSzpQbWSS2fkvxRgc2q7urOg7Ok5hSgRBrDPlZxrSNkSd80A6esRs5rZlwpY
         pmxQIXk0xgi2Oj/RwbO6H9//dcgRNOk9YIzIBi74jwIEhdYtKKGNV3qcQ5Q5km8oSqmx
         0aNSz7DfqpbtptALh9oSuC2C7l6tiraP23d5pX7Ls2W06fwkiB7aq5VBCmYQKZz3V5O5
         eCTQ==
X-Gm-Message-State: AOJu0YxVV26dkynH0CWxD3RpIGilJsnHlBJddckvDYgfpiA1gFyr3tWB
	uy0E1AwnUIMLZv6uXG3zhy6DTIuKD6C9H3ttc5e/C4rL8KK05PakxUch
X-Gm-Gg: AY/fxX44I90g/c2A+dLYVyDs+Pp7Un4uenWHntz7b9j5einbz+5NjUxLvVM5iOHEaF6
	r4NTy6Zrq1yAATqMjwT00mu3P9xR+qaBUdYuo1AVtiQagSGg+/HhTrIEduq15AcmvJ4qgTOH77B
	NmUwZJIrKzUlU54TCoEBjUh8fc1w+y+UMK3Br3lLkla3RKDncObGD/T7FfQipPSNMsNUwU3RSi7
	jA8gjWgq76rt5W94nmnhPoL20nrazqHnMhoMZORNA+jcbJQYwXNWzG5qHyFK2wsZs+wfs+oIGnM
	arx9UysNFdBhvkUlSEk4gZnTc/Fx8UFcBdiChcgcZ9DypHvQH+1IgrIl3E2WU7lOyUqLfo7Wqsc
	SfoPRnhQFRTkPn9svel0uFcNHvk2peV6d0qnDM8w6hMjkTVFtZ8y3HPXI6zOtNPMJHNtQxEhZ0G
	IoXzq5KvVkm+mTrBy3Ljlmejgu2pyRcrK87rsuNJY99zyxCNk4a4o1HKyxZ5PXZeas5ztheXNm3
	MN3nSwz7oFr32CXmtoxe29Q
X-Google-Smtp-Source: AGHT+IGtuKI5qFtb6bVvEi5z5XQ8k2RY7CgH49pTzGJ37hLsQLej8EohaIgmffXocttMVOc2pcKR5g==
X-Received: by 2002:a05:6000:400b:b0:425:7e33:b4a9 with SMTP id ffacd0b85a97d-4324e370c67mr23635694f8f.0.1766597609763;
        Wed, 24 Dec 2025 09:33:29 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:3371:7b65:aaf4:d2e4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1af20sm33237553f8f.2.2025.12.24.09.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Dec 2025 09:33:28 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/4] dt-bindings: can: renesas,rcar-canfd: Specify reset-names
Date: Wed, 24 Dec 2025 17:33:21 +0000
Message-ID: <20251224173324.3393675-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224173324.3393675-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251224173324.3393675-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Specify the expected reset-names for the Renesas CAN-FD controller on
RZ/G2L and RZ/G3E SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml           | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index f4ac21c68427..dab79dffef4b 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -188,8 +188,9 @@ allOf:
           maxItems: 2
 
         reset-names:
-          minItems: 2
-          maxItems: 2
+          items:
+            - const: rstp_n
+            - const: rstc_n
 
       required:
         - reset-names
@@ -232,8 +233,9 @@ allOf:
           maxItems: 2
 
         reset-names:
-          minItems: 2
-          maxItems: 2
+          items:
+            - const: rstp_n
+            - const: rstc_n
 
       required:
         - reset-names
-- 
2.52.0


