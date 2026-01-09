Return-Path: <linux-can+bounces-6086-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0433D0ABCA
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 15:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2993301F27C
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E30F30F553;
	Fri,  9 Jan 2026 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="p2YsF4uM";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="DhseYY84"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC6E30DD2F
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969925; cv=pass; b=kviFKiiFWeVGo89YT1s5GQLBcuRXVoY/dqcGoXsgat56c3nBSd4iASTH7Dj8SKhfurZMD7/lVDJFvgtnQzT1nHhLC/ouSESKxLxF/jHJSLsL2uv4nPtOYi/4gpgxXvgonSasL6bjZxyC8eb+akVE99OWV+7gYQ0BK3vRv7YB81c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969925; c=relaxed/simple;
	bh=x+UYLwaVtZgLID4dhGYmQYQeS3M94whiqJyjC7VTlWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Y1KdZ5zJYMMzZ3YmMQ6a0rcTfrEdhjWI4lAyZGV60PShiCFaTaJsSxBunt2IyRFJ82L0sacFucwVYrYcKawCAnm2EqZYj9DTiRlwJfNakg8qXkaBSFClxfBZXRI4RDuAZDCCmhojtLd9f3qTYOUaOjc+EE4SCWkIMj+nuQrsQtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=p2YsF4uM; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=DhseYY84; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1767969735; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ky4oXJjfqeu27C/Zw6mBdwsMPIGT4788RAZdd070RxQE+xSG4J0efSkNRJkNnoC5a2
    AhnzghVCcpohv3sL3AbUQ3wHPg+jHb7U6qhDq+4eVDQx58skDxArB6hdUzfJsdGPhbv0
    p7kc+w1ONcw2mfF1HM23tegTdMmlGKsTtNNp8mvL7lEwChBVbDt1DzzjUbKkBo/5N2qQ
    dgkT1Apr48hh61JRP8nSZK5GhaDRkd5rd1h2LHGfT3gaib01XH4xYWS9PABHwV6SlTPO
    XN1dwjesqepaRAbdRRGCfI+a6ylTYuzqsqA6iDRZioFHaRCVm0Hi14PVjOBgrBYMv2Ci
    JfMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767969735;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=5txjQcSZ0dslnm//dJ82gA7TULgJNwlLe02I6ywQKiA=;
    b=hILmiX/yXv3lCJLqt+VHF8Oen+wRiFRS8YiToZyvBpOcJW2/Ing5VZrPfklJWZcTpI
    5dnMCQ3RSBWY8ut/JMIlhyUpGDmIThCHMBrDVFFgTQoeaL/FGHe95ghYJerqVo5IUBie
    KZ7i940SXdVds3Z2A94kKNEU3KhQHa8HKXTtBCe5YsgO7mpfCbjIX4XfUcC17OAeeN8q
    WS2x1fN+W+MHG+L8ZAwzUlu8Glp9a/AfXOPn/LaUrNGxtyxLw5gNj4qMtTtwNHFm/9YF
    xwK6VTq9TVqJPRxST2ezKWxxbeKz4J3bOnMU7qyIuVnJjI5Jb/NBYJVE2PjNMf4mkPyT
    kYxQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767969735;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=5txjQcSZ0dslnm//dJ82gA7TULgJNwlLe02I6ywQKiA=;
    b=p2YsF4uMJpmAdwnTHAeKd61jlhE3akndnsbn/gGvdh1HAmc3ICVGgtk95l9Gch2JbN
    61iOcHud1ms9wYTCwbUhv5fBnvYVuOoLkIU3BfSlfS+6ejbCWZbV+8I2glzXnZjwYm4+
    LzneEhq7XUDqEcHHJDpDJN8FqsxMMNW0bNXpvu6b/O/u81/Y0LTbwQ3KiQvRNHp8FCJ7
    7xgAYAN+q7thXArSAzWVVfzWxtnEkVQLGL6P5QW2azgkargHRQlCAVPD7BGDUcCvOtl3
    BDQ3iM00lGDuWjEjotnlKXlau42ZAfqhZMrYoV0TLM1MtQ+OxbA7KodgGNy3ecTnp829
    kacA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767969735;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=5txjQcSZ0dslnm//dJ82gA7TULgJNwlLe02I6ywQKiA=;
    b=DhseYY84iTp5NZCTblr+mwXw5zxE+tQxG4jn8vNwqmuyhCHTQ0D5i5rFEOLeXmwhaw
    tgMx6QlUke62ujSWshAQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b209EgFPL6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 9 Jan 2026 15:42:15 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/3] Revert "can: raw: instantly reject unsupported CAN frames"
Date: Fri,  9 Jan 2026 15:41:32 +0100
Message-ID: <20260109144135.8495-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

This reverts commit 1a620a723853a0f49703c317d52dc6b9602cbaa8

and its follow-up fixes for the introduced dependency issues.

commit 1a620a723853 ("can: raw: instantly reject unsupported CAN frames")
commit cb2dc6d2869a ("can: Kconfig: select CAN driver infrastructure by default")
commit 6abd4577bccc ("can: fix build dependency")
commit 5a5aff6338c0 ("can: fix build dependency")

The reverted patch was accessing CAN device internal data structures
from the network layer because it needs to know about the CAN protocol
capabilities of the CAN devices.

This data access caused build problems between the CAN network and the
CAN driver layer which introduced unwanted Kconfig dependencies and fixes.

The patches 2 & 3 implement a better approach which makes use of the
CAN specific ml_priv data which is accessible from both sides.

With this change the CAN network layer can check the required features
and the decoupling of the driver layer and network layer is restored.

Oliver Hartkopp (3):
  Revert "can: raw: instantly reject unsupported CAN frames"
  can: propagate CAN device capabilities via ml_priv
  can: raw: instantly reject disabled CAN frames

 drivers/net/can/Kconfig       |  7 +++--
 drivers/net/can/Makefile      |  2 +-
 drivers/net/can/dev/Makefile  |  5 ++--
 drivers/net/can/dev/dev.c     | 27 +++++++++++++++++++
 drivers/net/can/dev/netlink.c |  1 +
 drivers/net/can/vcan.c        | 15 +++++++++++
 drivers/net/can/vxcan.c       | 15 +++++++++++
 include/linux/can/can-ml.h    | 24 +++++++++++++++++
 include/linux/can/dev.h       |  8 +-----
 net/can/raw.c                 | 49 ++++++-----------------------------
 10 files changed, 100 insertions(+), 53 deletions(-)

-- 
2.47.3


