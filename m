Return-Path: <linux-can+bounces-2694-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E59CA1B7DF
	for <lists+linux-can@lfdr.de>; Fri, 24 Jan 2025 15:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20F13AED43
	for <lists+linux-can@lfdr.de>; Fri, 24 Jan 2025 14:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C221292CE;
	Fri, 24 Jan 2025 14:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="djA+yVLl";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="45Diy7nS"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639C12BF02
	for <linux-can@vger.kernel.org>; Fri, 24 Jan 2025 14:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737728831; cv=pass; b=SXd3baNG3z//20WMfn6rxVxNnKenr+8Nk7r0qwpoOlz4xIsvgfba29QWwrDYUd9/3SQTbVnUESNzb7uaIcQe6gongOVUYiYP+KR5FTOp7kxyVlecG8JokJ1QjOkOyQQ1uJq5v6eDzAFdDxwDXddkOKix+53ORk//LMHZF3yZnI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737728831; c=relaxed/simple;
	bh=ULeE3sbGwhQciMjVJUe3ZiVL1mufRZnvW+59hsMiUi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OS0xLa2XV1Z+/wfl68NNQhoO/UOuCOagRT9EtFGMh1bb6y8ppwi08Tzk8IlmJQWPYXMmvsku2OvSdvUb7N8SBXSmkSUQJ7SXEqefd2OKvbzWdj4lgc+X4QtmJXUWQHOvP0GdB1W/IlWm1mrelYT6d67vKZwrp1vvs2XMSFRDM68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=djA+yVLl; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=45Diy7nS; arc=pass smtp.client-ip=81.169.146.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1737728634; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kGVG3xbLYgJB0IKTeoQt0euLh4cSE3WSQoj69sAIRaQULU5pdzIbEM7U8rqpezLtw2
    D43uusdV+mLizZPTuGGKnP3owYdKR7IKI4vmAkerr49w9s0NCjVnvSKneFf+hxP/DvHF
    RZ3QvwU7Eo1n1GTmzmNWWr7q68h0spOWO5u2ErbkNF5oP9DGKiQXUTXMUX8LKpGwLd40
    dWQMz6pcp7cJl13ztso04YLgowVjPjkIV4VyxAJ7KlJzKVBIavyCuvG6XRPgSzbfCHNa
    nUbO2XbzKUZyc9oGzCn4noktGCSebIhGras+Z5iZpzwjObeBF3RmZv6heJVeoZSdUaZZ
    X/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1737728634;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=T/GlSH9YqMQuBHWRYBvlE/hytt00ZqDNga7vYn0VIW4=;
    b=S3MOgnOO0b9J4tDio+MdsBX27W1IAgdkuQVe3tyZFIp9crIIyMmmhXFvfpgzJ5fDF7
    XCebQAgyxBOYFkNxFcjzjxPMyYRgdcyi2WDzTaezylgdiUUGDlJEfRiCmwrpO44VyN3r
    GzP3/j1XMivRUDiFPtWRsDDHsfReQaCCboUkFMxUmqlt9GRbqnXrP+uE0INkFzo1t2xN
    jITr8nqkWpwp5x2v7fSqEQB5KWaDMzaj0Uew/265Mvcvek3CeaVxVdpv4F6dj056dACL
    JMQDHWWkilXoMGiBgr8sPe1gpXFP3etuDi30uGbfpq7D6JAsFkIo2i83dPQdjhxgtT2n
    Rz7g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1737728634;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=T/GlSH9YqMQuBHWRYBvlE/hytt00ZqDNga7vYn0VIW4=;
    b=djA+yVLlyQMfcJOAZpHUcEYxnaISFXCpYvBxY5uEUlrZnvXVfQl5YiW545ZfGfcd13
    S+uCYFZyLSiHBi94eZrOsSxN4wIvHsq+d8+JzZxQ5oD+Y2QNtRM6OtmZXu9cdOp3/Kuu
    d01T093iC6Hc1wdjFB8sPfALlzKG306gvJpIJIFNjEX2EkMirnkbLnAu60Gn3nGo3ifz
    AKRssZilFu5t3Sk+ghjPBqRS+7CP/kdXHnqcEICnw41h+bnkup3p4AdfFekVxm4fPonu
    frBgYwlSkUd3MZpT+kONa89f1DoEUh4PNLDLYgccU+E6QAWa2zvitisZ4p3qqH9WEEHr
    8V5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1737728634;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=T/GlSH9YqMQuBHWRYBvlE/hytt00ZqDNga7vYn0VIW4=;
    b=45Diy7nSecrDU2hN35EO1Hg3sFFRVaYcqAKQg/RX7yAe09XUKw84rEzzJm3IiA4O7K
    6wBzFn7EE9I78fbV0SDg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 51.2.21 AUTH)
    with ESMTPSA id Ka08e410OENscEu
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Jan 2025 15:23:54 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH] can.h: canxl: support Remote Request Substitution bit access
Date: Fri, 24 Jan 2025 15:23:47 +0100
Message-ID: <20250124142347.7444-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

The Remote Request Substitution bit is a dominant bit ("0") in the CAN XL
frame. As some CAN XL controllers support to access this bit a new
CANXL_RRS value has been defined for the canxl_frame.flags element.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 include/uapi/linux/can.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/can.h b/include/uapi/linux/can.h
index e78cbd85ce7c..42abf0679fb4 100644
--- a/include/uapi/linux/can.h
+++ b/include/uapi/linux/can.h
@@ -180,20 +180,21 @@ struct canfd_frame {
 };
 
 /*
  * defined bits for canxl_frame.flags
  *
- * The canxl_frame.flags element contains two bits CANXL_XLF and CANXL_SEC
+ * The canxl_frame.flags element contains three bits CANXL_[XLF|SEC|RRS]
  * and shares the relative position of the struct can[fd]_frame.len element.
  * The CANXL_XLF bit ALWAYS needs to be set to indicate a valid CAN XL frame.
  * As a side effect setting this bit intentionally breaks the length checks
  * for Classical CAN and CAN FD frames.
  *
  * Undefined bits in canxl_frame.flags are reserved and shall be set to zero.
  */
 #define CANXL_XLF 0x80 /* mandatory CAN XL frame flag (must always be set!) */
 #define CANXL_SEC 0x01 /* Simple Extended Content (security/segmentation) */
+#define CANXL_RRS 0x02 /* Remote Request Substitution */
 
 /* the 8-bit VCID is optionally placed in the canxl_frame.prio element */
 #define CANXL_VCID_OFFSET 16 /* bit offset of VCID in prio element */
 #define CANXL_VCID_VAL_MASK 0xFFUL /* VCID is an 8-bit value */
 #define CANXL_VCID_MASK (CANXL_VCID_VAL_MASK << CANXL_VCID_OFFSET)
-- 
2.45.2


