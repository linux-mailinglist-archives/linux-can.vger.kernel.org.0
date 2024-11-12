Return-Path: <linux-can+bounces-1984-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC9F9C545D
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 11:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E69A1F22223
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 10:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07512185BE;
	Tue, 12 Nov 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uuitetAc"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A082185B3;
	Tue, 12 Nov 2024 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407781; cv=none; b=Gykd4aZFNrJIcyxP+SC12GwYDjkqW4yRsS0JLXa+IgnXAXmORFkw+LTUwcGb68G2zQtYupNJsatd5Ow+/AY2wwYegEfjzkPtMHiUKC4GdONhsPF1KJ5YnIzUQE+S0YTs4Gg+fw2hxYsfs0xI8QF5cZxrXvv3h3azHQPdqAoJbo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407781; c=relaxed/simple;
	bh=mKHfPw49S/UjlwDth40dYQc6804kuiAi0oR24zuo3jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GMATVCu1oF3QGlD2PW83VfIzcxTs5YCk3zTv+SF3/+JRDvc0Ja2hKxRjpu5sW/r6lfNYFOx5EA4SiVCrvY9/RQI9zelch60NJx/uGWtgdi5B4j4+hDDukGt9QS2h83dT5aDJuzbdMR4+r6xIst0N3BQJTkeLx88JeqEmh4L5w8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uuitetAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCDC5C4CED6;
	Tue, 12 Nov 2024 10:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407781;
	bh=mKHfPw49S/UjlwDth40dYQc6804kuiAi0oR24zuo3jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uuitetAcfKakqE4Ejx/T2nMnuPKTF2I+J9yj0KFhMPNapi0IFt1TMJrQ3/C/6lvJQ
	 ssE2g7ukz3aj0wBI/koODWiB7JaBjBeDzYfp9NDEKWOyRrKRf9mP4S1rFYsMvunsAd
	 wAfR8tWrFH3j6QSbq/LRd+tmEuThDZ+k3FxlzDpPTieOHixSa1vJu1RP9iGBGFlz8e
	 d3oBfgAdIm7PoFCoUNu0X8ts3FCee8yf4oNOYbQlSZMcR/Bl91Fhzs1cqXraVVQM6S
	 KkKxQ1Fz/86JdeZpFq1cuUtNoeCA6zlUa8f3yLfAF5GUYHedhGjRS00bE8T6eEhYK7
	 SOeg468SEvZ6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	robin@protonic.nl,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 09/16] can: j1939: fix error in J1939 documentation.
Date: Tue, 12 Nov 2024 05:35:51 -0500
Message-ID: <20241112103605.1652910-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
Content-Transfer-Encoding: 8bit

From: Alexander Hölzl <alexander.hoelzl@gmx.net>

[ Upstream commit b6ec62e01aa4229bc9d3861d1073806767ea7838 ]

The description of PDU1 format usage mistakenly referred to PDU2 format.

Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20241023145257.82709-1-alexander.hoelzl@gmx.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/networking/j1939.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/j1939.rst b/Documentation/networking/j1939.rst
index e4bd7aa1f5aa9..544bad175aae2 100644
--- a/Documentation/networking/j1939.rst
+++ b/Documentation/networking/j1939.rst
@@ -121,7 +121,7 @@ format, the Group Extension is set in the PS-field.
 
 On the other hand, when using PDU1 format, the PS-field contains a so-called
 Destination Address, which is _not_ part of the PGN. When communicating a PGN
-from user space to kernel (or vice versa) and PDU2 format is used, the PS-field
+from user space to kernel (or vice versa) and PDU1 format is used, the PS-field
 of the PGN shall be set to zero. The Destination Address shall be set
 elsewhere.
 
-- 
2.43.0


