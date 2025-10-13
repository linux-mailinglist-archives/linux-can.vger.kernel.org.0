Return-Path: <linux-can+bounces-5150-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C986BD2797
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 12:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 79C4D4E9060
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA14D2FE571;
	Mon, 13 Oct 2025 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIF55weH"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F8D1A3154;
	Mon, 13 Oct 2025 10:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350241; cv=none; b=PRCxho4ZYAgBwjuoSuUsV9vePbtUkAqhUis50yeZsl1JlmQDeUH1NDoBnD8SBXmKQKfGSX25JbT5WVUwlP+ZZ+9+IwzvoiD71qt9ZFcglKflXQmWn0GIOarrQ4onI4pq1wgGFlTbsQxXJEIkVLZN+zPezezjah3EgW1N9J5XqL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350241; c=relaxed/simple;
	bh=KO0MTTWHWriOYUm7OmjhD9UN3x3VlLRIdp0ZRS5IGbs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MNE0WWoqiCOXwEHatxbpzSEdGeK/fAf8DqhTkvFowF8eeoLSQhPuQFrNf61O7IG4iY/AjlkIMAu6cYSPIh/AZJY8iZIjbC/6U9h+7FUPsEEeOFz8Yt7LBWa3YFvxWZInnRqd+8tLIJFmQCXdPCCUtz0V1dOyWaiVoSXhskaIgMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIF55weH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 810A9C4CEE7;
	Mon, 13 Oct 2025 10:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760350241;
	bh=KO0MTTWHWriOYUm7OmjhD9UN3x3VlLRIdp0ZRS5IGbs=;
	h=From:Subject:Date:To:Cc:From;
	b=MIF55weHNkPHICZ/mxgB5ITKal/N29QOlkWikj5hraIWa1qDbSX0gmUYfgshof8qc
	 FiNowypduJq6r8BkZobMEA8PV7jlq7ZiSv32sIot5EieMsJlau+m3Grw7th/vbCFn8
	 kQ/IK9ElN5GrEGDfJlCR+VUFFr55zjA3e8GP4ESwh2T7txJVOBFlzQtog2GBQLmP3Z
	 KKjL12LXEUsuWOMDaGKvAxab/KM62dmkARAl3Bi37B/twnBaBv+9BeNX89qZgcMNYG
	 T0YWYAhvkFG6snhXRz4LjixDlE2WEPBQel0mo+JXjcGYm68fhbZvjPpiq+9QDjpclT
	 2Pj9RM1K7Fdmg==
From: Vincent Mailhol <mailhol@kernel.org>
Subject: [PATCH v2 0/2] can: add Transmitter Delay Compensation (TDC)
 documentation
Date: Mon, 13 Oct 2025 19:10:21 +0900
Message-Id: <20251013-can-fd-doc-v2-0-5d53bdc8f2ad@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA3Q7GgC/23OzQ6CMAzA8VchO1uyjTg+Tr6H4QBbgUXZtMNFQ
 3h3J1w9/pv2l64sIFkMrMlWRhhtsN6lkKeM6alzI4I1qZnk8iy4kKA7B4MB4zWoWmLZG6MKVbN
 08CAc7HvHrm3qyYbF02e3o/hN/zJRAIdKaV0aUXAu1eWG5PCeexpZux0w4fOVnlsOnfVdQNB+n
 u3SZFHlogLSIm1vX9Qvsp3SAAAA
X-Change-ID: 20251012-can-fd-doc-692e7bdd6369
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=KO0MTTWHWriOYUm7OmjhD9UN3x3VlLRIdp0ZRS5IGbs=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBlvLoheUJgzbY0Pg5pyY8Pp6noz/2e1H++U7tjy8/gTz
 WOrAmc97ChlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRkmeMDA/1XDdL765KSHho
 4DHlTf2MyMshW8RtPSuYTHXbEwKmvWL4X1S2qG2aTH5gm/TKqNMi526taDto3Xgibtrn3se6Yod
 OsgAA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

TDC was added to the kernel in 2021 but I never took time to update
the documentation. The year is now 2025... As we say: "better late
than never"!

The first patch is a small clean up which fixes an incorrect statement
concerning the CAN DLC, the second patch is the real thing and adds
the documentation of how to use the ip tool to configure the TDC.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
Changes in v2:

  - Fix below "make htmldocs" error:

      can.rst:1484: ERROR: Unexpected indentation. [docutils]

  - Change from "Bullet lists" to "Definition lists" format.

Link to v1: https://lore.kernel.org/r/20251012-can-fd-doc-v1-0-86cc7d130026@kernel.org

---
Vincent Mailhol (2):
      can: remove false statement about 1:1 mapping between DLC and length
      can: add Transmitter Delay Compensation (TDC) documentation

 Documentation/networking/can.rst | 71 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 67 insertions(+), 4 deletions(-)
---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20251012-can-fd-doc-692e7bdd6369

Best regards,
-- 
Vincent Mailhol <mailhol@kernel.org>


