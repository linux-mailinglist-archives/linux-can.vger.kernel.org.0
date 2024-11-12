Return-Path: <linux-can+bounces-1986-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F409C54E7
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 11:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75A02B25557
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 10:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A8C224608;
	Tue, 12 Nov 2024 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J58g0gU6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595A52245FF;
	Tue, 12 Nov 2024 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407850; cv=none; b=M/LVpXeH8mkqlxEQne7RqovYGKAFzQ1N/IaPjSYcB9QppMOQqRvjbV0f+A5/lk2FbKuZnl1wmoH6Pw9qXn936SzU/mbebYGDcJuuyZK4nNL0EcnTh9R2jGO/raDECJfsT35lse4H9/6Lsyvm80Hi57PKz8VCyP1gSgC8Kl6pxOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407850; c=relaxed/simple;
	bh=vSRvIIeuP0uL1xcfrQcdNYT7Bq8X8dLrpOUUMuR5bYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNp2NTIGYnycxbxAbFhMekbRxAiNPF8Gi5//EpP6siHeZ0rGhD/DOnmfFiJ8FiVd1JVTTSQjAQMisQ421rrZkHcNR2vwWxSCofTVuxp9lnvQzHOpJqsEeuwIdUx1xBsCMmt1vSJDqPNFnkxgewPLERz8iEuk0788f5+vtYsouf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J58g0gU6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4D5C4CED4;
	Tue, 12 Nov 2024 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407849;
	bh=vSRvIIeuP0uL1xcfrQcdNYT7Bq8X8dLrpOUUMuR5bYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J58g0gU6nKZ56rK3vO8vcVgMd2qN7R0K6tKkpI08aSx4VwWg4QZ9x8/A7f/70XpEM
	 STfIMz5nu7+NqRYTckZUPUxMFVygs9G+Nh5tpzg9akdUHbszBQ4IO3SJXq7F0XwwPQ
	 AMAavo9sHZLqblyCX2fjgBlvnPvMAK/ls+eJ9+0m/T9vVpwYiVKSzZh4eurrqxbCRU
	 suWMabRosFXcN/hip8OkKJ2u4svblPRfg/5413uYsGGq1WzN54XY+5447MFjoxNS6N
	 IUIhUhptRe/S9kUAZKWFRFFNK51QH5hF9LAJOoUNHpqOmGPdewpyO2EmR+DStRF5KQ
	 23npRUauPgQgw==
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
Subject: [PATCH AUTOSEL 6.1 06/12] can: j1939: fix error in J1939 documentation.
Date: Tue, 12 Nov 2024 05:37:08 -0500
Message-ID: <20241112103718.1653723-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103718.1653723-1-sashal@kernel.org>
References: <20241112103718.1653723-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.116
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
index b705d2801e9c3..80b1c5e19fd53 100644
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


