Return-Path: <linux-can+bounces-8052-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hO2pB9HUTGoFqgEAu9opvQ
	(envelope-from <linux-can+bounces-8052-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:28:33 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B840171A5D5
	for <lists+linux-can@lfdr.de>; Tue, 07 Jul 2026 12:28:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8052-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8052-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 407B03053E7C
	for <lists+linux-can@lfdr.de>; Tue,  7 Jul 2026 10:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9693E3153;
	Tue,  7 Jul 2026 10:24:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55703E1D16;
	Tue,  7 Jul 2026 10:24:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419867; cv=none; b=eds2G0iQf/cUylGVZfKWxGdg0RU22/60qG1F8pub75CZqD9mJQcRFoT8vGUepXTSuInD83p/lAdwOadp+VsRFbY9C5FCpLl/bfP6UHvfcDDRS+BuT3vDNhAstvhvZzYtOaUJyoBbN89/d3AGOjaJ7zkeUAICytP3T9isOh/NhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419867; c=relaxed/simple;
	bh=rfQA24pNBdai4SXVx7SQMIib5Yam9+s344kX1w9crpU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JggoGJdM8rwOFU9naWxuRFgGtwDJ4DBS7GLofk9GVmFYAQYMT1kB7h7GcYzAje7K4lczd7wchCX81zAWZElr4DdtIwiOrC5nEWs+4bw042bHXwozhikKrdJ8Na3q31r8F0dQPtm3sQPGtJlw7TVWU2u/3mEdm1u9O2CTg5RE2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6431F000E9;
	Tue,  7 Jul 2026 10:24:21 +0000 (UTC)
From: Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
To: mkl@pengutronix.de,
	mailhol@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	bmasney@redhat.com,
	biju.das.jz@bp.renesas.com,
	tu.nguyen.xg@renesas.com,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 0/8] can: rcar_canfd: Add support for Renesas RZ/G3S
Date: Tue,  7 Jul 2026 13:24:10 +0300
Message-ID: <20260707102418.1646159-1-claudiu.beznea+renesas@tuxon.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:geert+renesas@glider.be,m:magnus.damm@gmail.com,m:mturquette@baylibre.com,m:sboyd@kernel.org,m:bmasney@redhat.com,m:biju.das.jz@bp.renesas.com,m:tu.nguyen.xg@renesas.com,m:fabrizio.castro.jz@renesas.com,m:claudiu.beznea@tuxon.dev,m:linux-can@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-renesas-soc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-clk@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:krzk@kernel.org,m:conor@kernel.org,m:geert@glider.be,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[claudiu.beznea@tuxon.dev,linux-can@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8052-lists,linux-can=lfdr.de,renesas];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,glider.be,gmail.com,baylibre.com,redhat.com,bp.renesas.com,renesas.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can,dt,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tuxon.dev:mid,tuxon.dev:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B840171A5D5

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds CAN support for the Renesas RZ/G3S SoC. Along with it a typo
fix patch was added on the CAN driver.

Thank you,
Claudiu

Claudiu Beznea (8):
  clk: r9a08g045-cpg: Add clocks and resets for CAN-FD
  dt-bindings: can: renesas,rcar-canfd: Document RZ/G3S SoC
  can: rcar_canfd: Fix typos in macro names
  can: rcar_canfd: Allow the CAN FD clock to be sourced from fck
  can: rcar_canfd: Do not set registers selecting the CAN mode
  can: rcar_canfd: Add support for Renesas RZ/G3S
  arm64: dts: renesas: r9a08g045: Add CAN-FD node
  arm64: dts: renesas: rzg3s-smarc: Enable CAN-FD

 .../bindings/net/can/renesas,rcar-canfd.yaml  | 17 +++++-
 arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 39 +++++++++++++
 .../boot/dts/renesas/rzg3s-smarc-switches.h   | 12 ++++
 arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 46 +++++++++++++++
 drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++++
 drivers/net/can/rcar/rcar_canfd.c             | 56 ++++++++++++++++---
 6 files changed, 170 insertions(+), 10 deletions(-)

-- 
2.43.0


