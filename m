Return-Path: <linux-can+bounces-1724-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E47A79ACE04
	for <lists+linux-can@lfdr.de>; Wed, 23 Oct 2024 17:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CFF8B2831A
	for <lists+linux-can@lfdr.de>; Wed, 23 Oct 2024 15:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78BE1D017D;
	Wed, 23 Oct 2024 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="HKbRbG+w"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6DE1CB529;
	Wed, 23 Oct 2024 14:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695250; cv=none; b=ZB96J63UXFOonDbi2a3xIZe/xahmuOSGzGHwCLr9P/VV1Zw7DKht8U6C3bMCrnzDNvWihDhyWJQDgE0Z40d0ExZO5xFgpruQqjjhamqEBs1XK6VHdI6lkaF/1ZUiallH10w/daSf/95O58+jhCVlLw8OjCKAWcvdlZXzTZIEJjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695250; c=relaxed/simple;
	bh=sUTQ89VuWsBilXCnlJLOKScXnZBA5syrdYKolmmZkio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=FKQwdCO9CIJMbbl3JieTMTWy06o4ClUT7/fU2rKbYoTLpcKgviQ6zJ5xxR9vbeXgD+0SKDV55qpVmVsNICLuq0+09VsYqPL4jW5OBXzeChcHZkQJTeEl4V39/aYUAWUin3LGMJ48Jt+gfngzbwvG2vD9ObP3uqXzc5xsuQ5pY9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=HKbRbG+w; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729695230; x=1730300030;
	i=alexander.hoelzl@gmx.net;
	bh=sUTQ89VuWsBilXCnlJLOKScXnZBA5syrdYKolmmZkio=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HKbRbG+wf1O+zAjGu49gSHjrvaTe5Ac1MQ7wX42mwTlVEYogtTmodLk25qQfGa+r
	 cnTtsZ1mvO1HTt6MVm+vGq0zl03p6QzwiS34bbbCDj37cXw0Ngg71Bq4Fo1fcfuR6
	 TgGqdZuKbHbwRMqTKSPDlQbnAkLwhVhBM2iucHsqjiYfABK/zjJEK5RgECG3clEj0
	 DIB8RS9VjEuDEgAGZdVLsnKM2KvvfiYu3D8uEiXnU2BsF88WiWA8ON2DdlOfHSZo0
	 jrK3UY8b74N5ED39VVGqKMOj0zL0uKy68avnuD+/WCT5Ha2kgXCe77uikb9hBFNxc
	 29N+dSa25YNZP1nv+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([213.30.210.165]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MvsIv-1tvzuj0Jxn-00vtFR; Wed, 23 Oct 2024 16:53:50 +0200
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: robin@protonic.nl,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net
Cc: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Fix error in J1939 documentation.
Date: Wed, 23 Oct 2024 16:52:57 +0200
Message-Id: <20241023145257.82709-1-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fz15U7KeG+KVT4HSSSV/nF9ie7V0iXvroEQUuHh3eFKBXWo2VYX
 TbHRTiag//raFjwYWWSJGQ3Ys7N3ybczMcxyUbkqX9zkcA+mVmvad0iA4cfKfU/C6tIFacF
 UiiHa7CCCkogWGgVjxQyIsLVYEwHxeGviglmrPGdgOtLIvaQ7Im5oCngxmBcxZVsnM04rX5
 M0XEY9Z9Ty7p5kspJVRsA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UcqbzR29RSE=;I0wa9TS6hlJ6OukFRgyDN4FuYd1
 lnLCsuKsDLFAo9D325bsXiqAA8+yXe2JntzRgI76R5Nzi66NJ9wQpfk2LLV1hGGKWUTrpDGC4
 yh2nrBB75AFjNrSxayqMRx/zmPBIjT61RQc5PnYsnu1kIBbWl5JRpAB9c8Ya2eYaddfW4FTdU
 Kzsr2j83Tnhw/uYtAFudeNuUkDQhk40P0BzMNqm5ZuVI/4fHf3WlFndreVrwi7V+xWfabj5S1
 t1bPiCQ28NdfdGiCHZRDH6+iDb/7sOkPKAXCMLghlbguzMf8UXQvXEf2Nn3prvUbWHhP97Gjp
 /bkam0ZY+H4xkErhha5+2FF/Sbjr+BoOFwd2VvCMENP69qig58oNJb2RN/SGaQCn2EGNaej9k
 H+eXvyBT3qaBmjkl6K3TakhrpRGSCVMNCmc6ai2QwpJe/Oh28RN4CurnqZXoPGgrcWzuFvYN3
 bZHzSgzmteWNyZoC7XebTMH8ahUahXpBXL8TZWnhOUmoqpl24fzDdIG6JKoBCkoIXJC4XeaNS
 w+7AQwSIzivIsF9zr5iI0QcQDwJQs0OEZ+QArr8kWRMaQvyI+SCURD2Q/WiFm62ukE+bQSKFE
 3d+L9DKQ7XJax/2kLnua6Ug4lu+V98ik7szpQPqVZ6Y84ZR9fgBYbH54PQT6gSqja/fgvkPIy
 M1vgx7Y4S+qZFjwX2kBdgTkeCmQX3kXtiAwvL2N93tgwmASCGgz66tf7nDSGRQ6s2IynGMLbn
 z1/fd0nBKu9wrAQg7DQW4iF78jpzavPWkUJvWdDYLsi2iyR/dkSZWxz1KwCpr8JPhmcJoLlGD
 ThBBjIwSHlrxII1R0e/c6Qww==

The description of PDU1 format usage mistakenly referred to PDU2 format.

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
 Documentation/networking/j1939.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/j1939.rst b/Documentation/networking=
/j1939.rst
index e4bd7aa1f5aa..544bad175aae 100644
=2D-- a/Documentation/networking/j1939.rst
+++ b/Documentation/networking/j1939.rst
@@ -121,7 +121,7 @@ format, the Group Extension is set in the PS-field.

 On the other hand, when using PDU1 format, the PS-field contains a so-cal=
led
 Destination Address, which is _not_ part of the PGN. When communicating a=
 PGN
-from user space to kernel (or vice versa) and PDU2 format is used, the PS=
-field
+from user space to kernel (or vice versa) and PDU1 format is used, the PS=
-field
 of the PGN shall be set to zero. The Destination Address shall be set
 elsewhere.

=2D-
2.34.1


