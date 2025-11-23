Return-Path: <linux-can+bounces-5611-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE3CC7E00A
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 12:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65A894E044B
	for <lists+linux-can@lfdr.de>; Sun, 23 Nov 2025 11:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF46A2D5C68;
	Sun, 23 Nov 2025 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxK1Tt8B"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FED2D5412
	for <linux-can@vger.kernel.org>; Sun, 23 Nov 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763897014; cv=none; b=DcJmdV2diDYNA2pKQbJRS9/8DVUfrc9ZqbAYMm/VxjvnCIdMi9GHrwXX5J8HD6CLt+RIWVTQzuHSu5WEEbQFyTb0ipQL8UTv/BwVrZjXA93OKON6xQLHp3F4LoBzoRNZU+j3FxtYbiXfC+TmQ0RH6R4bazFS0ofbPQnXofDMcWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763897014; c=relaxed/simple;
	bh=YxkQBwXeaDK5Ahlcqc7tH6KRyGRRKLvTUkvYlpv0wpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgeARV+4opBomn10+ntPBMAoWXpMIeo6TuU1TZoa9+eKosZQiXz5yp2U4FEoKk5NgA9ZmpUsVYegt3zW8iwdswByBR5AQ2msBb824BrvltPrpcGwm2a1YXYP2Dp8d+G0IsnCkz1Yyh/iKt8Vp+EAl0ZPgz/cykmf63Pkob9ErL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxK1Tt8B; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42b3ad51fecso2730529f8f.1
        for <linux-can@vger.kernel.org>; Sun, 23 Nov 2025 03:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763897009; x=1764501809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gUVsPl8aKiLhU+zuYZZLZKdCn4OQAATzfIPdBb3xnLc=;
        b=ZxK1Tt8BZ3N+1VTQhHpa3hX5VpouGF6tXtHHirA8wdpH0P9mHQuG8NbZDwOL/dhyRe
         btrQKx7NjaaWJTdsPQWQ8PyPpf43xzgnOj96vXFuU/MDT2ACR0U/HXIMViSPc8RVWvT2
         tSfKyHErYNJft+3qvBc0Ymgcuv5XSop1uCzeg0gLOtpoZh+9STNdhLsfp+FuAmPz8ojp
         z1YBD/0cmMNhAz0aZDvOrbgN9CzB0Cy37bIYWaIfAXj0Zgxw+xVAgVPL+sGdmyBy98Br
         ydxLo+Fh298ewCdFM69MgS8lxCLagJe5Z6+ogU6AsTr0P2iAovtTe+z4+g8eZ3So3sPc
         mRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763897009; x=1764501809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gUVsPl8aKiLhU+zuYZZLZKdCn4OQAATzfIPdBb3xnLc=;
        b=Ks3km7WoE/tQctVn8+l79ia/zB/4rD/q2y47fR1HK/o2+n8mafmUl8b5DNc+4NUrge
         nfbGB20zJyG3ni4pE4UmNOxK7JdIVGQQC4tNHG1uKk/R30pBoGPHzQA7wsNr0cgMv0DG
         n13T5Zs0i+NAKwz1qbf8Gme5znNZkYCUEnAeZuVAPunEq4TiQbNhAIMiJbSYnpYla01e
         tT3/8XXjCiiyaS5U9/3v4toFRYYYsfbO7ZSbyQWuTiZCmB2ertihhZTC2rWeFCzFjAtu
         lnJ4dN5UwcOr3T8dxIJVSlJpkhfvfKBfkq/MOmBRqW8hht8UwPGQF2/EteJJhXic1JSG
         mrPA==
X-Forwarded-Encrypted: i=1; AJvYcCU847ftw71sve9QldRrKyX/1eH7eiiZ90BFlXhbVcmpN13lIUYtyiQxr3X75wqeXQhH9AZjvVxD77A=@vger.kernel.org
X-Gm-Message-State: AOJu0YySwj516F1y/SNkUSlDUBNQVpGaoGxxjxTX2Hi/Vu4WiwKFSfeh
	sH/y4M/s1FqWJ6zkZUoXHbbs9O4ZUgYH7jyWHukF3+JtJY0XVGMRDVd7
X-Gm-Gg: ASbGncv1O7IJPhm9HlSk9Uvy0Kh5FGmIoo6ySsYreOQtrzzkDLuQk7KJ76UFdY+PvSu
	ow+T17OBm93Pv+vibfBm4axLd2GGIcSxEwQ1SCUd068t7F6Zihh/b4fYqY4rZ4FWBGbp3E3n1Gs
	4QTBCfMYrtZuTS7CR397H9Tmhhx+Au8v0aForRTkiNlOEYL9yErQJD0jVKy9v1VVrvANZSe878V
	F+BOMIMpYzZJmD7mePlKU2YUlWL7HWs+ZQGVrKc2D9165GafZFzChbJESMqwkK92RABFr0ba0eZ
	Z6+lXYeaaHLfNLAH9/zc/gw3wUkFmvj10ghU2JNGnIIYGTJkymJVuMha9u4W/YeVuLvM5VXHajQ
	eK7iSVoN+6H2viUfdcMHDHOqXRvvOzuingZ92y1GCGWlDTdHaRaDJcFwaxcd24YcEvHQaG46QcH
	pRIBhLEqKkZjlSkM5nO/20MuoobDFQ6k7utmJbWKORdHBD66MjbjfP1/eVmeGhwZUKOomZaB0=
X-Google-Smtp-Source: AGHT+IEx7AWatN2BQs4y2OJkC+YYVlkGVZrC6zppZE1i8KxRoEXxPptJb0e6TIw+8Q3zMRycyNQj7w==
X-Received: by 2002:a05:6000:250a:b0:42b:4961:eb4c with SMTP id ffacd0b85a97d-42cc1cd5cc1mr8751552f8f.1.1763897008927;
        Sun, 23 Nov 2025 03:23:28 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f49a7bsm21765703f8f.19.2025.11.23.03.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 03:23:28 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/2] Add FD-Only mode support for R-Car CANFD
Date: Sun, 23 Nov 2025 11:23:19 +0000
Message-ID: <20251123112326.128448-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/{G2L,G3E} and R-Car Gen4 SoCs support additional CAN FD mode called
FD-only mode. In this mode, communication in Classical CAN frame format is
disabled. Update binding/driver to support this mode.

This patch series depend upon[1]
[1] https://lore.kernel.org/all/20251118123926.193445-1-biju.das.jz@bp.renesas.com/

v1->v2:
  * Added conditional check to disallow fd-only mode for R-Car Gen3 in
    bindings.
  * Dropped has_fd_only_mode variable from the struct rcar_canfd_hw_info
    as it is checked by the dt schema validation.

Biju Das (2):
  dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only
    property
  can: rcar_canfd: Add support for FD-Only mode

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 24 ++++++++++++++++---
 drivers/net/can/rcar/rcar_canfd.c             | 14 ++++++++++-
 2 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.43.0


