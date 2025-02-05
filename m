Return-Path: <linux-can+bounces-2731-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E5FA297FA
	for <lists+linux-can@lfdr.de>; Wed,  5 Feb 2025 18:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C2B3A96F1
	for <lists+linux-can@lfdr.de>; Wed,  5 Feb 2025 17:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC51FC0F4;
	Wed,  5 Feb 2025 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="Boaq6NYI"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E891FC0ED;
	Wed,  5 Feb 2025 17:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738777640; cv=none; b=AR4HQ8+YoQiI9IG6sFblfJQWRs6D/VH0nKaDpKpVq6yW/aMDGneeDX4HUPRcq0gZN9cO21pC+FKzPrdfHlsXoi37y48+sop3xXh4eMreLCVdhYmPFsQ6hsQ+4CzoN6w24aSawxRmLtlTf/BUC3Qc7A6aoPTCUFgySY3tK7a8nik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738777640; c=relaxed/simple;
	bh=uCA3hDHeWqKH5Jb81QxdvEZEftcWKVVuqDUDv2vvtLY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q/51sGBVa04EVNfbLuefiaokSXVlMltTMtz4fTLw20wbciunhdbBIbbbsrR9L3BzQhKG3M2Y8rFQP5KpR8x8Yc40qijJ646md0RpJ5ki6eivjLjZ3Ioe9YIjh9lYpq63nRv7QyzbhOhtEsZVRfT8a7DxvgVTXaD2PTfb/a4dmDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=Boaq6NYI; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1738777625; x=1739382425;
	i=alexander.hoelzl@gmx.net;
	bh=JI1FYztUjeOKORF/DHbHzq8NYe5mUE3ErLZ9RQzbumk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Boaq6NYIyI29VI6eeBR2FyMpi36oE+pBscz47gXd3vL5XrQZG/ryfmoiORa5pkJ8
	 Hb4WaU1hR7138cKAlcPlLZRpgZC5mjNr8S6S8bSC+ie3aFUafqdDV9WeZuJSQlluA
	 Jkt1i0j3b5mYrD83GarldJWYKZH1ZJ0q4zR6oOFukFqo4tC0lvm+OKXcG3TXUn7gN
	 K82C56nr2uf4Kga4N5Pdx6IWv481IWlzz7ZMcUBMOd3Wo2/5i+96Zs6i3sViFqhjR
	 TmwWJYndPWi+GXKLAU/0FJhWP+49Mqwp5qxQL2xSQlfcCfbsfvkgJuBf4TWvJty36
	 IdkdoV7hbwVgXW41Jg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from DE1D1414HLA0.ae-dev.softing.com ([213.30.210.169]) by
 mail.gmx.net (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MV63g-1tp7B12P0I-00VoLG; Wed, 05 Feb 2025 18:47:05 +0100
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
Date: Wed,  5 Feb 2025 18:46:51 +0100
Message-ID: <20250205174651.103238-1-alexander.hoelzl@gmx.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PuB3104qPD+JAxAbov6wA6KYDthL+/hNXO5b4Hj1BjrK6WUnpSV
 7khvZPs10KiwvRmUfG9wKKVwos8yTg5tuefEdSJCcQzooxe2xTmhbZ6KY366rvSqcR+5FyS
 RkCT5eVgOm6t0L9XPWFq17gqSjIRItuR25YImcWkoeSFKkL9e8eR9pGSGttUO9WQCN/Bnp5
 NtIhN9PB1YEiuOe6pPNng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t97O3RMI1AA=;2/Fmsit5OCXAQVZIwVOqEFk7EAq
 wPSj6HjMyyQtmeMwu2DHx5qrLmstoUIyV+PuuXCrkLv5Nsq6ZHmQhyrsx9VvkUY8NAGgi7aNv
 P1mVY6TLqip6j9T9nn9c3tkBvZcd3E7UzB67eIX7I+jEwMUJ6lcxuBSQQf27I56X1lS53Eh8D
 lKDn7i71YvUe0kPoHaL6LMlMYluCA8Mlsb4eNRN2LFobN1/FXW3QheLcZmDIsvM+4PdNRzKPs
 TZCkDvBDTjEBS4MDi2qriE8B+TB5aYjwEQkxoWs/dxU8B2gE/wA92/Fm+4IxqkZsOZizz7IJa
 o1x9rfHoOAO3N7FLJ1xwWU8ZA0Nu9mFSiJHJF7S9WTwAiHemNvtvxDYDzRckwmf8vq3pVokzR
 UyYsy8w4UbWbZSdFd4gcC8wcXbtEkPkdvgG//bisNojhBdWUieQKAsYHF4bTJ81FVMirKuKzq
 gGhWtJl6zYgt8doAiO/iDs2pWPmXIrnCZ4boSmUQwMInryqHVqYekUyMvdwXUlvbTnDgomvur
 J9OV+ln4lMe4K/0JwdwnH8uE4FT64BvxpwAnzu0KqVOju0nvij2xLCdW5tVj1LrbFGT19VgQ3
 fQos2uCw1NIE4FmE3IeUvnwWayi1iQfdhPgASx7ThxP24xuAej8Wd/tykRyVgaMapUP0Ui4Bf
 Fq/qumN/p8Gfylo6tbwMtaidotpt++rw9QUEyne2atwzbh62VAjSg9QHpzdGuL4tS56sEZgzR
 Jyc8ctD6pCvO7ZMAsf8kO9hPiH5KRw7PP6AaWZ5vxbKY6Af9p8COFSPxG4OLE8CYIdZTYD5vx
 3xQqN8cX5Gp2fHZbETx+4LO09UC3ll+QzxEuWSC2Lcfd0imD+Nbx9qmnaPfK/niA1Z8J6uKzT
 jKOz/UqNUUaRwO0DkrP8NG7YkGnuH8DsDpO17sMcA8O6nXHmX96G0h5ZWpl/E1qvb6f5pIKsD
 CagamZHR8Y5bW6o7d+0UdXJIOahtx5brHSIvkY8SY8LeBltJPyG8xIFa24Nj/ClWiIpGtZ836
 TNT01FU/sllgDDAGEpU5+R83DAkaEoYq2eYeH9QEO1vMZQ92BIzAhy549dpsJ2RFcYujA4Eny
 6XaCRO/YRVBk/2koV6T3Mf3L7SMvEyDwykW+/0GTQL+0Vn3ZC5q642G7QeJ4FKJG4SWa4TkUm
 b1uhoAHiBMNv5UGCAephJZNJRsEKw83pK9VnOm/NOvDaYv/3ZyoDAnm+jHYqn24Z1Y+iu2WTW
 IIfaWMzI6wFQaHyniWlMZ1046Zfk74BvzBDncGlrT87d9JtHBbbPgrcPv7fI2ofzzulyYYj09
 DVHwtKDJwZ6VWoHMKYmgEoZ+bf0j+inQfW11ddXtDCdS00ai7yEi/GHhJ9F7VHgbLQq

The J1939 standard requires the transmission of messages of length 0.
For example the proprietary messages are specified with a data length
of 0 to 1785. The transmission of such messages was not possible.
Sending such a message resulted in no error being returned but no
corresponding can frame being generated.
This patch enables the transmission of zero length J1939 messages.
In order to facilitate this two changes were necessary.

First when the transmission of a new message is requested from userspace
the message is segmented in j1939_sk_send_loop. The segmentation did
account for zero length messages and terminated immediately without
queuing the corresponding skb.

Second in j1939_session_skb_get_by_offset, when selecting the next skb to
transmit for a session, it was not checked that there now might be a
zero length skb in the queue.

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
+		     (offset_start =3D=3D 0 && do_skcb->offset =3D=3D 0 && do_skb->len =
=3D=3D 0)) {
 			skb =3D do_skb;
 		}
 	}
=2D-
2.43.0


