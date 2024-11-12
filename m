Return-Path: <linux-can+bounces-1988-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B209C5515
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 11:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7C11F26485
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 10:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C649D1F7784;
	Tue, 12 Nov 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNSKWWaY"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6521E103;
	Tue, 12 Nov 2024 10:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407889; cv=none; b=u5lRsjx/FU5OGZl9dnwiXij2Jg16IL5FLzvS6Wkh65hfuFAud400lw/Ee9K3QUaGi9Fbk20mfAe6QUyIYRpXD/IdBQhPAiEr+Xq/4RQkcqZ9nO4gdKKxO9wHKIqEX4vU0uIwWNY/cV0agaQ9m+/Rvxfa0yomRYhiz+wX56TChKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407889; c=relaxed/simple;
	bh=SCRBbqa7yEeu9vl/EFKHr1yv2U8iV/5Sj1IyFgS1c1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=anwWnqv8IkN3pzcQP5aWQ8klwiqyvuZ02+d2A2zV95OSPWeITBPwZPuK/jRCrJlPjoozEb1lspa2NCQWM9SsBsauWJNVub3o3aHlsg/K56ylm0ojGssKIbh1CK/am4aADQb8Pmck7fvs5aBzNhpW+S+8yK2r7YfaZ5X+iFSj9mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNSKWWaY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A9AC4AF09;
	Tue, 12 Nov 2024 10:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407889;
	bh=SCRBbqa7yEeu9vl/EFKHr1yv2U8iV/5Sj1IyFgS1c1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNSKWWaYMfAdV4qfitBzlOjthQns1RFASELzCcNeJnGSW0eleb4Ud6gdcyZ0fjRB6
	 5t8ohQ94S6WZ5DU5bSwApmmlej7wyruyZwChfc6pVtCvFmwrUnjbSCVfwdYiGtAHx+
	 /2nlEdLBf2mKXNL0US4S6tFfCI4jvYnG+ZYkcbOjUD1w/j40jIEfFsOqbp1TYYBnOs
	 0eoToesvSkb2f7wYl17FmG48II9Frk/JhptpEqixhnGYQjyZLVDqGlZoea95a4Lb1j
	 tOfYZC4+/EdatEy8QrwafIDWRBlOK04UUz9v/1CJ3Xx+/hGed6weoNIHtv+Ixpxn7C
	 OkRvbJhHmYULw==
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
Subject: [PATCH AUTOSEL 5.10 3/6] can: j1939: fix error in J1939 documentation.
Date: Tue, 12 Nov 2024 05:37:58 -0500
Message-ID: <20241112103803.1654174-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103803.1654174-1-sashal@kernel.org>
References: <20241112103803.1654174-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.229
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
index 0a4b73b03b997..59f81ba411608 100644
--- a/Documentation/networking/j1939.rst
+++ b/Documentation/networking/j1939.rst
@@ -83,7 +83,7 @@ format, the Group Extension is set in the PS-field.
 
 On the other hand, when using PDU1 format, the PS-field contains a so-called
 Destination Address, which is _not_ part of the PGN. When communicating a PGN
-from user space to kernel (or vice versa) and PDU2 format is used, the PS-field
+from user space to kernel (or vice versa) and PDU1 format is used, the PS-field
 of the PGN shall be set to zero. The Destination Address shall be set
 elsewhere.
 
-- 
2.43.0


