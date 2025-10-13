Return-Path: <linux-can+bounces-5151-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DDFBD27A6
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 12:11:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CA3454F00F4
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 10:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE4C2FF155;
	Mon, 13 Oct 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuJiUiHl"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684CA2FF14E;
	Mon, 13 Oct 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350244; cv=none; b=bLHjaq1vUZngGQFavFY0nVxlycnO/dh7Z5zTE/H1UgNOEDPTHBzapNLVA6LrHLTJlx+KiCzKvT2/kZg9xMdL3vK6fbPU/aXCLTBEaTJ1rpwXIwZ88HYtoZBHe47zM0qSs12Iw1UX2Fs/W0p6zstC4E/fmdHVT0JvKuK2Pb9xKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350244; c=relaxed/simple;
	bh=hvsex+jt2rVqZK9V7K+FVvNoMhemQw6fzEbsRr0vloU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IGWDEOqYvhNPM4XNnb2PdP/493h9eDZ4zgOGiYR8uCCPGwa6aALGg46x15IkW5T0/Tiv2s+nTqla1dJ9UOtyvXRruLnRAwyIBaQmjp9bE8Tu628BGwSWnInxOKZQGCj8f3VD4/jfpr3zy6cyD6PEMa93xBRpm+eUVoQsZb9nDe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuJiUiHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFAE7C116C6;
	Mon, 13 Oct 2025 10:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760350244;
	bh=hvsex+jt2rVqZK9V7K+FVvNoMhemQw6fzEbsRr0vloU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YuJiUiHl65uOsFY9d+RdVHM9RvFu1MviQzJECj+VW4AZcx5ySCb2qQpW+U9T9MVml
	 UOnK3BjLPvWo/XMO725J48k8g9qw+/DM4QOVNhVmOS+Jqc1icxXwIWyovk77U0S4ox
	 rQjF4x3yY24disvRVENOZwE54UbZe9eQIrm22PDeHWyEVW4gMxdAVNK2SYh5Ubrl1/
	 zGFLutldh2WJmaah+h/EsnVmY3VcfIG4/BY27zks9OV+SAaxtSv72PvOYD+qGax4Zm
	 X48u7QQpddvyLdV1sliPNIHwO77/+/FCALOInvCLEM4EJES9NBu3bMAyi3K8q78rkw
	 6CQUFbXUnvTfw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Mon, 13 Oct 2025 19:10:22 +0900
Subject: [PATCH v2 1/2] can: remove false statement about 1:1 mapping
 between DLC and length
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-can-fd-doc-v2-1-5d53bdc8f2ad@kernel.org>
References: <20251013-can-fd-doc-v2-0-5d53bdc8f2ad@kernel.org>
In-Reply-To: <20251013-can-fd-doc-v2-0-5d53bdc8f2ad@kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=hvsex+jt2rVqZK9V7K+FVvNoMhemQw6fzEbsRr0vloU=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlvLkjJL37p4PXtXfEVk5e7OAU8316fprXmasiFVLX6S
 PbHzxXWdZSyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZgI8yyG/xWu5/8pBu3kPcJ5
 8IrR8+5iqS/T5gleD3pd82GJZ83D9zYMf6V43lZxSjBInV5u7jUv8UTqqcMvio3cOXfIFzkkeG7
 IZAQA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The CAN-FD section of can.rst still states that there is a 1:1 mapping
between the Classical CAN DLC and its length. This is only true for
the DLC values up to 8. Beyond that point, the length remains at 8.

For reference, the mapping between the CAN DLC and the length is given
in below table [1]:

	 DLC value	CBFF and CEFF	FBFF and FEFF
	 [decimal]	    [byte]	    [byte]
	----------------------------------------------
		 0		 0		 0
		 1		 1		 1
		 2		 2		 2
		 3		 3		 3
		 4		 4		 4
		 5		 5		 5
		 6		 6		 6
		 7		 7		 7
		 8		 8		 8
		 9		 8		12
		10		 8		16
		11		 8		20
		12		 8		24
		13		 8		32
		14		 8		48
		15		 8		64

Remove the erroneous statement. Instead just state that the length of
a Classical CAN frame ranges from 0 to 8.

[1] ISO 11898-1:2024, Table 5 -- DLC: coding of the four LSB

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 Documentation/networking/can.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/can.rst b/Documentation/networking/can.rst
index f93049f03a37..58c026d51d94 100644
--- a/Documentation/networking/can.rst
+++ b/Documentation/networking/can.rst
@@ -1398,10 +1398,9 @@ second bit timing has to be specified in order to enable the CAN FD bitrate.
 Additionally CAN FD capable CAN controllers support up to 64 bytes of
 payload. The representation of this length in can_frame.len and
 canfd_frame.len for userspace applications and inside the Linux network
-layer is a plain value from 0 .. 64 instead of the CAN 'data length code'.
-The data length code was a 1:1 mapping to the payload length in the Classical
-CAN frames anyway. The payload length to the bus-relevant DLC mapping is
-only performed inside the CAN drivers, preferably with the helper
+layer is a plain value from 0 .. 64 instead of the Classical CAN length
+which ranges from 0 to 8. The payload length to the bus-relevant DLC mapping
+is only performed inside the CAN drivers, preferably with the helper
 functions can_fd_dlc2len() and can_fd_len2dlc().
 
 The CAN netdevice driver capabilities can be distinguished by the network

-- 
2.49.1


