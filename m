Return-Path: <linux-can+bounces-1985-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD8A9C549C
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 11:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94D921F2246C
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 10:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021CB21E116;
	Tue, 12 Nov 2024 10:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUkSckTX"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B2221E110;
	Tue, 12 Nov 2024 10:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407818; cv=none; b=Oajjd98wOnaY9bEw1LPU2YzzLPZtpfaeTcbmPHgnlj7S7CLig9DqVnB+Iw+semB21oseKlMaDx20Pb+hE9nFv/jIXEbuHLorTMTZ3hjw3auIjogVmtp/7aPz/IxplmWa7m6Jy5tHpY1kJmopJDhkW6BnWI85rVTwPFApObfB6+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407818; c=relaxed/simple;
	bh=mKHfPw49S/UjlwDth40dYQc6804kuiAi0oR24zuo3jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S4idEK1nrDMwR0FyHtD+rmeXlT6Xx3KxV2EXz3jnqZi8LJqs+dprrTqQgnCa//huvqGKQvp6oWXfA7f6nlZR5poZE+rLnJjXk8wi+Lvtme8uw1uVfJ3QcrQ5FkV5PUD7VZwPcjxogvO6bA4KouNXq9SCyzjgqq4v1CGnkZ/WLH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUkSckTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04837C4CEDD;
	Tue, 12 Nov 2024 10:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407818;
	bh=mKHfPw49S/UjlwDth40dYQc6804kuiAi0oR24zuo3jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NUkSckTXu/69B3dxEt/EDA+rS55OcypeV8pBUyX7LaLIgxNNNJ/MEvqaYTiTH3YlY
	 FLN/5QzU+taXGxMcns230/VCArxLZruKw+MArCJOTVcIZQP8UFGt0RkiBSCVJzipdr
	 5ouM10X+0vwDmlMbt+2T8Gu5eKm564uqo9CkKrl0eJQMdino8MmcVU3epkxoME557x
	 6WPZbfou4nEb9sV6ko6lIpkAy/0hQM9P3QZdkKP66rrleHFQVPmBizFrTeSALNswVH
	 KRXtSsPyvviLhPBWTcZW1vJxyUrvFLnphw8CC0LXTZiMQSL/a66M1u9PiHwUTpT25b
	 FWbOk0dZGWwqg==
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
Subject: [PATCH AUTOSEL 6.6 08/15] can: j1939: fix error in J1939 documentation.
Date: Tue, 12 Nov 2024 05:36:29 -0500
Message-ID: <20241112103643.1653381-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103643.1653381-1-sashal@kernel.org>
References: <20241112103643.1653381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.60
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


