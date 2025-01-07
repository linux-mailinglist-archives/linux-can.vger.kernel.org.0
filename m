Return-Path: <linux-can+bounces-2554-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C63E8A040E5
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 14:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3A9B7A03E3
	for <lists+linux-can@lfdr.de>; Tue,  7 Jan 2025 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A21E9B28;
	Tue,  7 Jan 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="Fnlq7XCQ"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619621D8A16;
	Tue,  7 Jan 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736256801; cv=none; b=FyxllBBA3RS7o/CZTpwjXNlRiVvvPEo0glTpkIfEXm8zlHGNiJUt7lGy2vu0bzpbdLbNoFEKGlNUlZbhBRcUlQ2fXwxM7GshR3l7sovymd6+eGH3IQ7eZzOMVpF5AZ8pVbz4ScXEcEDLPaxC7ZiXYWpBtWyksuS3uJt5bqsMsi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736256801; c=relaxed/simple;
	bh=TdqMvyqkFK3t0e20oc0y8J8iWp2lnCxllhFIe/KdBW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b5/eAstw6KAi/YWA926oz2aCJVraK7sxpgw9tdd+05TJ4Q/9aUAHHvZ0KCXC4xibNYhvuLWHK6FoSi05wY6+aR9oUULcR1pdYaKmw+l/+z7yM/yCnTtn/bwcHefJaYqxlMptvF/j0al5cCE2Ntx++yldq0ioRgn9Qd15kYieWZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=Fnlq7XCQ; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1736256796; x=1736861596;
	i=alexander.hoelzl@gmx.net;
	bh=3vZENEhYaLn5OoH9JiKPV1IoDRJq7AhaUgo6tpJ03Yo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Fnlq7XCQki0yH/zyoR2RoFY15f9LzoDgMS8H9oEbLuiGDoVoaPTab5nBqWdrEs+7
	 BpAZG84RnGYipFhLtA/P7m1SGI/FEGjGrSOmHoyHy5w/HrPsBS38pehpHLTZvBGTJ
	 Y/hutAXgaGLidwFFYARTUnX8OJTOejamV5usK1eQOSP0/RtbouOvYJR5JdyIgOyEZ
	 I2RDB1AAbXfdq/j9HUugde8SXh4oh76kNnNTSLhq4dLHBwXVdtRXMJGBLco3a2DNF
	 Z/T4vHZITqOCuCXHljqsHudZsnEo9m5PwQqZQvqy6cgi1fQdGKyG3GReQGpUCH/HC
	 Jv+oalS/I7JWWv4w9A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from DE1D1414HLA0.ae-dev.softing.com ([213.30.210.169]) by
 mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MGz1V-1tIDPj1jIh-00DDxx; Tue, 07 Jan 2025 14:33:16 +0100
From: =?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
To: robin@protonic.nl,
	socketcan@hartkopp.net,
	mkl@pengutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net
Cc: kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Subject: [PATCH] j1939: fix unable to send messages with data length zero
Date: Tue,  7 Jan 2025 14:32:17 +0100
Message-ID: <20250107133217.119646-1-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WwIgbbt7Z8x4d8vt09DUCOWCr5sNbIY3oSVw07cLreXVl3YljGo
 Kqx76YiWwgAIyGjKVX7xPTIHw8UCcqij5J7f8AKKCEGbxFDlXjQfyH43S5U4acNsbu6NNC1
 tbJehnQ7ywMHHZ+xqO96B7olew3UFh8rxzFj+o6/IyZHHDvGDJg3zilmHG4u/3G/fOuulXG
 mTkMl0XGiUfPQOr0W03+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:g1d1ENM46V4=;b+2MFb0ejJUQdvK2LufMoHSEn+J
 wuoWMorkTDUHEqRRxRgpSnAWx8qP9eL5VTkg2y432ijSFP2OhG5nwQRz1m0fYX14T1hb1HQq6
 tfwXjtR9fLHVevhsQ/nVWO8Elum9cyEPJoXlxxkOQg2C6vLLbIZWGs8w10AyWyuKyKFTFNYbd
 vPSPhbjhOU34VBGnDX8dAB1APEnIB7TTju84uORWB4vpwFu3W8XMA2Nb1e2g3x4c/nK3wQb44
 Zx55rHPbzbeSHl4FiPtoPt7zAUifhRDNxcDQulxuHLrWtPiw7N8gIpNxXpAbtg5MXPabuHAqm
 3cO/jh6btFIMoniY8StE1jYKiD8Onh639AImCYHe5IW0bIJLgoDKKBzL5ScJ5zJuiwIzYwtsg
 JxMDqsWP7k76AaMOthPmCo8yxL90F0OdMl8sHr9rjKhGuTSMm23gDyuZ8w1MZ+DfUibiPnLGE
 Mg5K3MAxEGll/2uIpmrbyGbud5G23yOhTx4V6Xx0MUCbl3e7WK8R4TeiQ1V5P7SM+PR8KNJd5
 oGeGZOr/2EK4AZNuYRnBqG2pJ6ZnHenWR+V0u4OkqMxJsuFaGHbAjPWVEqASoRAdMVBioG1P1
 Dt4R3nJr/GXBWN0/aOLVbYKG2beineEPgTwcn7Q1KNTeXn0DnH50nhmGqjZzPHZSA6mrSyZuc
 0qcNE8K2ZLC4goJQjXeDAh3rrqLBO9XzLgVVSZYu9zilMf63hOhUaey98q9crOPHWfMi4D/XG
 xPtPBOvaRwqeA5qCegEFGNTtN5lWjNjzzo/ze7APrn0Ar/NhoUbavgsmy4THZKrTw/E6YebM/
 chWGyWKcUJSIqp4xM1BUMGAASLKRPlAX3otvcEJuVRE/Cs1Jb7Qo2BDKEKuieogoUAfntcwmi
 +WAA8gsIS8YazupMKv3FCtfWFLwviYN/S2NAMT0J1Kyu52/MsnYpolYo/EEQsuavo/LAUIjh5
 5h2BZhe/+EB9Um+bnCPpoSelIWILl81BDMR8XxYJpx91Yje/zzfflHotC19xZmLTuplZhLs10
 EM5Nz/0KIlpskEVFr3xC7KuTzxpbn6IeBv3jQzMYdBrFw9r3ZVH38UiVZy9qoZSLopzOID/8t
 JxFOsCya+uwkNRwwskPiiEYgMKki4v

The J1939 standard requires the transmission of messages of length 0.
For example the proprietary messages are specified with a data length
of 0 to 1785. The transmission of such messages was not possible.
Sending such a message resulted in no error being returned but no
corresponding can frame being generated.

Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
=2D--
 net/can/j1939/socket.c    | 4 ++--
 net/can/j1939/transport.c | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 305dd72c844c..17226b2341d0 100644
=2D-- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1132,7 +1132,7 @@ static int j1939_sk_send_loop(struct j1939_priv *pri=
v,  struct sock *sk,

 	todo_size =3D size;

-	while (todo_size) {
+	do {
 		struct j1939_sk_buff_cb *skcb;

 		segment_size =3D min_t(size_t, J1939_MAX_TP_PACKET_SIZE,
@@ -1177,7 +1177,7 @@ static int j1939_sk_send_loop(struct j1939_priv *pri=
v,  struct sock *sk,

 		todo_size -=3D segment_size;
 		session->total_queued_size +=3D segment_size;
-	}
+	} while (todo_size);

 	switch (ret) {
 	case 0: /* OK */
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 319f47df3330..99832e60c08d 100644
=2D-- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -382,8 +382,9 @@ sk_buff *j1939_session_skb_get_by_offset(struct j1939_=
session *session,
 	skb_queue_walk(&session->skb_queue, do_skb) {
 		do_skcb =3D j1939_skb_to_cb(do_skb);

-		if (offset_start >=3D do_skcb->offset &&
-		    offset_start < (do_skcb->offset + do_skb->len)) {
+		if ((offset_start >=3D do_skcb->offset &&
+		     offset_start < (do_skcb->offset + do_skb->len)) ||
+			(offset_start =3D=3D 0 && do_skcb->offset =3D=3D 0 && do_skb->len =3D=
=3D 0)) {
 			skb =3D do_skb;
 		}
 	}
=2D-
2.43.0


