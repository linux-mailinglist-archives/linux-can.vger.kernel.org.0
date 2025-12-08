Return-Path: <linux-can+bounces-5826-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E52CADAA7
	for <lists+linux-can@lfdr.de>; Mon, 08 Dec 2025 16:53:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0545303AC8D
	for <lists+linux-can@lfdr.de>; Mon,  8 Dec 2025 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188342DF12F;
	Mon,  8 Dec 2025 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXvnbqKy"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E072BE630
	for <linux-can@vger.kernel.org>; Mon,  8 Dec 2025 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209031; cv=none; b=UThgDR7acyUO1SNSsqYqPbZG+ZjcY1Yn9EsVM64NQ1rnQtHG53Hv1XJbq7FZtWSM5ZopG9q9efoumJvyIXntz/qo9vbpSzRrJIL443vE3nXlFjP1BexmuSPBc0xfipjnY7zmPTkCHFGd2IKO7mXFNhEuF+lF3xpWou5YuN+ZiWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209031; c=relaxed/simple;
	bh=tlOo9dyRdPpU5qGbPx+r7yc55urEIGakEuFBzxg6tNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a29TMwrJ3HQJ0TMcFX+mKQlrhJgIELxR8XFktvlJ4a5SJICiicX6L1jsmv1QRVl0ZSYsXvvX31mZgBxpNGScMq/npubNcBR/c6byueaitqPuCkUMNwZkGoQu1wRn3fS3WMudA/hdSFi+nZX3fp0fxTnzyGIwjkNsX2BRTlh1qsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXvnbqKy; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477aa218f20so29756015e9.0
        for <linux-can@vger.kernel.org>; Mon, 08 Dec 2025 07:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765209027; x=1765813827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0DkeTPkNVXLcIqrE0+vJuuPcS/1UnLmUfSY7lOiFDo8=;
        b=gXvnbqKyUgjEfClf2bKPQCLEvgkqIa1gDIGeQVGkrimnD2w3f+YAYfHVwcI2Gf4ynW
         bkVzN0qjPpn2ugDxKbXNWdG2vuvMIDAx8JkixwkeL6EZBAjceyrFsojuK/atAcOq2v97
         zYHMAIlQORMbubnjnHl+gI8cR4aZKoo3rzO8YA+291NXbEOb6CIYIL9mLFF5Pc8wLHzE
         TATeA87HItsHbXyP/bfx3B3UrfmuXLDc/XzATlVri3OYbcT7uAzV9My7IMWFQjm/wFwv
         6LzDgX7ap1rBsaGYo92ZxmGpvLE21Wc7qLhbNMZqdikIOkeTuS8PeeiCCl29aWtk9V/X
         EEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765209027; x=1765813827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DkeTPkNVXLcIqrE0+vJuuPcS/1UnLmUfSY7lOiFDo8=;
        b=NcLwGs73p0odfUTWRFM5rUph6C5i9tk18rybJu/vARz3xwsn2LeJGfycA9azGXVbKc
         YHId9/roK+Sd4c7/oxWdYJTP3XLyhcyJu6lWivZjY5E+3IAUJu5B4DpokP8JX+bsVKwk
         QeAZo7xsFvLZP1CLDJILQU0sen+9Y6H4AOkal8k0hH+SHXqMmN9K67hM1uLxVNy86i0W
         yTRBjtqO11zCxBh/HXKI4iR6wDrXKpt7x9/d6Phi5AINhtlb7e3HMUtv4KDLcDsBCfr5
         20tqIhmullECRLTf+K6t/a8uRxcgu7JWIn0TAqWcbLYH3KedhXvoAfqMOLlldFRTbl4r
         CfUQ==
X-Gm-Message-State: AOJu0Ywrerp1TlFbqH6p4qmKEv1JvUIefTwfaasEGtwr+8/pHYlhOQ2V
	tTUhZS7GQ1S6UuBCMNyF8LQXs7lwDPtZDGF7CBT3UmjNG9hnm86OY/OU
X-Gm-Gg: ASbGnctUxluDOcxqV6ydyiPVBs5RuCJSfKjN/36qn8c2YTjRD1qDO28/tutHcARSDvM
	Gx+35Z+/us7Gv556HU0Adg2GhULhJNASlEtVhR96QdRdqpFKNTbCE2gnjaXEVlKk3jdAyVhP0GE
	39Ns+z9Q92cKKhVnrU3lQNqywIJJJ4m0QClvW6+LcUrFnRFkUH1pTQYyn9SzuYX+4gXqpJUWJp7
	IYw1UQbuFtZvZSdurC50R8sCJHUEYdVw7KE9vg/HbG9DTwDIdHndJDUimagzy8Sv3aQR+9OcGMh
	rWDJPVWv6ZER4pkUOatvUI+3hMI4YAVLVBpm3ysvOrjGOGm2T0w07omiv+CHMp+Rzo5H1xus62V
	N30iF477WuotQFt4dRfwK+ot0qamUa4MINwYtstPOjIOE9HSpnYqd8QEPJ9QJf4zUpHz0e7cTUl
	ZguVelcYPoW/JMDcLZjMuXweJeoHdlj6sj8g==
X-Google-Smtp-Source: AGHT+IGcN/kfIKnH8UEIcRMeENYQps70OLTJ0JNHqdRe30a1VCk8EhGuR6GFWFzu2Ojxaxr9I9XRIQ==
X-Received: by 2002:a05:600c:468a:b0:477:9f34:17b8 with SMTP id 5b1f17b1804b1-47939df129emr76804815e9.1.1765209027313;
        Mon, 08 Dec 2025 07:50:27 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:9aa6:8a23:82c5:2b7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b150878sm147717845e9.3.2025.12.08.07.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 07:50:26 -0800 (PST)
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
Subject: [PATCH 0/2] Add support for TI TCAN1046 CAN transceiver
Date: Mon,  8 Dec 2025 15:50:17 +0000
Message-ID: <20251208155019.136076-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series adds support for the TI TCAN1046 automotive CAN
transceiver. The TCAN1046 provides dual high-speed CAN channels and
includes STB1/2 control lines.

Cheers,
Prabhakar

Lad Prabhakar (2):
  dt-bindings: phy: ti,tcan104x-can: Document TI TCAN1046
  phy: phy-can-transceiver: Add support for TI TCAN1046

 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 5 ++++-
 drivers/phy/phy-can-transceiver.c                          | 4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.52.0


