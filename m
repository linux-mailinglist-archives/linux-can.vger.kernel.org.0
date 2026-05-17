Return-Path: <linux-can+bounces-7650-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBG6IN4rCmpfxQQAu9opvQ
	(envelope-from <linux-can+bounces-7650-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 22:58:06 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC866563DD2
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 22:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E3583018746
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 20:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38022F12C6;
	Sun, 17 May 2026 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b="efkqa/R6"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E1B175A72;
	Sun, 17 May 2026 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779051483; cv=none; b=Xm1AbDDzsSJ+X8CTwxrqPpvz38zPxv/KVu6EqPBlRsmjml2J4QU6j1TKWxwXNlejsiNktsc66bRRDf+4UgFjt2RFDSNh57hO1tQVpFdylV++s4Y5sbOVkrsVXiE4HGSGhH38gXxTsWv1CL0Lmy3vqLH1Q+HoIlxPHIgi7E/uG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779051483; c=relaxed/simple;
	bh=OEpCDADcP42wYxx+LvsgpY/7U5lcG4H5IZ4GD5tMih4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijRv5XF/lVDofPkRwToK39qnhvXwAR9OtUAFnqPQ9CUofn1mp/H58Wy6GUNNWPgtgSQKH7xp9jQ6fD7bbKsKEZh570bINI/+ArAWZCDr+UZAIxWTb2qgmAln3LvwIanF2j+w90LJV1T62x2etKjZcVcrVQnE6WKI0qNh7uaAlbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=alexander.hoelzl@gmx.net header.b=efkqa/R6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1779051477; x=1779656277;
	i=alexander.hoelzl@gmx.net;
	bh=m0wckB5JF802tpG9mL9D5vvDKnJt4KbQIWKHbYXnEvY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=efkqa/R653RbyczrE9lWv1JKnClqp9gdH78sJtOJlz+ih6cSfGb92TxCML/FnPnN
	 myHVlTkF9z8aXL7KQ8iZvPCOaqIyGpKDh+vA3Fd/K56gM9d4xddu+G51fhcXviGNy
	 iRz4Q6q93EHPkVikcW3sNuKA7ecKxadCetMgDGaZ6s9FudNxrIylHRZUORRfye+/x
	 RJw4qpSv7wK1wyMUwRw63PhfU4WJ0NZk7c+7DoDLMPSpE/237+NwlYHWXDXevmnsD
	 t0cdEYcbgKadqRVprJg3X2TkxiUZO4RIUskgukMtwypJfFrge64DcrpeOb/0k2SnK
	 +N+cpkIhHCMiqyAsdg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mnpru-1x8TRX0pC6-00aMDu; Sun, 17
 May 2026 22:57:57 +0200
Message-ID: <21dbdcce-1355-411b-8be0-32a0dd773853@gmx.net>
Date: Sun, 17 May 2026 22:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Fix J1939 implementation not handling holds correctly
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 linux-can@vger.kernel.org
References: <20260516143644.139561-1-alexander.hoelzl@gmx.net>
 <aglyT74qHffw0vRl@pengutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
In-Reply-To: <aglyT74qHffw0vRl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k+fn+1X61MnPgMUfBBE/ikifgiOOW3Syop2zGDAdzICkwIflQWV
 VrmoSUhOjaY4PppfjnQrcoWLJMyH5L2HUh1w8AR68UT70EywyrSiiXQAPtRGf3OZze8F9r1
 yiXbGURb6LWt8s+EpLvDKs5RkeGV/lW4f1ywEfUk6LszgWS8ZNXJEEGXEHlHp2LjqxN6Elt
 aH+LgjhaB6ibWrRrgLxUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yr6K3oNNYzE=;qdhljhkBxqz9pteKJj7nhLuuvDI
 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
X-Rspamd-Queue-Id: CC866563DD2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7650-lists,linux-can=lfdr.de];
	FREEMAIL_FROM(0.00)[gmx.net];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexander.hoelzl@gmx.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,test_cts_hold.sh:url]
X-Rspamd-Action: no action


Hello,
once again thank you for your thorough review :)
I'll try to send the next patch by tomorrow evening.

On 5/17/26 09:46, Oleksij Rempel wrote:
> Hi Alexander,
>=20
> On Sat, May 16, 2026 at 04:35:25PM +0200, Alexander H=C3=B6lzl wrote:
>> The J1939 protocol allows the receiver of directed segemented messages
>> to hold the data transfer. The kernel implementation did not handle hol=
d
>> messages correctly was not able to resume from a hold.
>>
>> Fix J1939 RTS/CTS session not being able to resume from hold.
>> Replace hardcoded timeout with define.
>> Add CTS hold behavior tests.
>>
>> Signed-off-by: Alexander H=C3=B6lzl <alexander.hoelzl@gmx.net>
>> ---
>> Compared to the last patch I removed all of the todo comments I had
>> still had in the code. I will implement hold notification in the error
>> queue in different patch.
>>
>> I replaced the hardcoded hold timeout with a define. I can replace the
>> other hardcoded timeouts in a different patch if you want me to, but
>> for now I only touched code related to the holds.
>> I also added a helper function to check if a CTS is a hold.
>>
>> I also added a baseline test case as you wanted. Altough in the future
>> it should probably moved to another file which specfically tests normal
>> RTS/CTS behavior.
>>
>> Also addressed all the comments Sashiko had on the test file and I'm
>> also now sending an EOMA in the test as without it between every test
>> there was a 1250ms wait until the session timed out...
>=20
> Nice!
>=20
>>   net/can/j1939/transport.c                     |  48 ++-
>=20
> Please split fix and testing patches. Otherwise reverting it for testing
> will break testing (at least it will make things a bit more
> complicated).
Sure that's a good point! Also the test script test_cts_hold.sh is very=20
much based on the  test_raw_filter.sh script. Now that I'm thinking=20
about it, it would be probably cleaner to move out the common parts into=
=20
a helper file?>
>>   tools/testing/selftests/net/can/.gitignore    |   1 +
>>   tools/testing/selftests/net/can/Makefile      |   8 +-
>>   tools/testing/selftests/net/can/config        |   1 +
>>   .../testing/selftests/net/can/test_cts_hold.c | 322 +++++++++++++++++=
+
>>   .../selftests/net/can/test_cts_hold.sh        |  45 +++
>>   6 files changed, 406 insertions(+), 19 deletions(-)
>>   create mode 100644 tools/testing/selftests/net/can/test_cts_hold.c
>>   create mode 100755 tools/testing/selftests/net/can/test_cts_hold.sh
>=20
>=20
>> +/* Time until session invalidation upon reception of a hold message.
>> + * Corresponds to T4 in the specification.
>=20
> I would add here documentation references, it would help another me in
> two yars to understand things :)
> ISO 11783-3 2018 - 5.10.3.5 Connection closure
> SAE J1939-21 2001 - 5.10.2.4 Connection Closure
>=20
> You can update version if you have more recent variants.
Oh yeah, the 2001 version is quite old, I'm using the 2022 revision.
Although I don't think there are any changes in the spec which would be
relevant for this commit in there.
Will add the comments.>
>> + */
>> +#define J1939_CTS_HOLD_TIMEOUT_MS 1050
>> +
>>   enum j1939_xtp_abort {
>>   	J1939_XTP_NO_ABORT =3D 0,
>>   	J1939_XTP_ABORT_BUSY =3D 1,
>> @@ -1428,6 +1433,11 @@ j1939_xtp_rx_eoma(struct j1939_priv *priv, struc=
t sk_buff *skb,
>>   	j1939_session_put(session);
>>   }
>>  =20
>=20
> Here comment:
> SAE J1939-21 2001 - 5.10.2.4 Connection Closure
> ISO 11783-3 2018 - 5.11.5.4 Extended Connection Mode Clear To Send (ETP.=
CM_CTS)
>=20
> The number of packets to send can be set to 0 to hold the connection
>=20
>> +static inline bool j1939_cts_is_hold(const struct sk_buff *skb)
>> +{
>> +	return (!skb->data[1]);
>> +}
>> +
>>   static void
>>   j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *s=
kb)
>>   {
>> @@ -1442,9 +1452,15 @@ j1939_xtp_rx_cts_one(struct j1939_session *sessi=
on, struct sk_buff *skb)
>>  =20
>>   	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
>>  =20
>> -	if (session->last_cmd =3D=3D dat[0]) {
>> -		err =3D J1939_XTP_ABORT_DUP_SEQ;
>> -		goto out_session_cancel;
>=20
> We need to document old and new sanity check behavior in the commit
> message.
>=20
> Before this change it protects only against a flood of CTS where the
> linux stack didn't managed to start sending the data - less probable
> scenario. And it prevents valid CTS hold support - most probable
> scenario.
>=20
> After the patch it allows to sende multiple CTS including CTS(0), but
> prevents requesting the already transferred and acked packets. So, the
> kernel will abort immediately instead of going in to timeout.

Correct, and just to say it again sending a CTS while the transmission=20
is ongoing is also not correct according to the standard. So a strict=20
implementation would abort the session on reception of a CTS while=20
transmitting. But that's a problem for a future patch.

>> +	session->last_cmd =3D dat[0];
>> +
>> +	if (j1939_cts_is_hold(skb)) {
>> +		if (session->transmission)
>> +			j1939_session_txtimer_cancel(session);
>> +
>=20
> Here we need a comment:
> The originator should abort the session after T4 (=3D< 1050ms):
>   SAE J1939-21 2001 - 5.10.2.4 Connection Closure
>   a lack of a CTS for more than (T4) seconds after a CTS (0) message to
>   "hold the connection open" will all cause a connection closure to occu=
r.
>=20
> The receiver should send followup CTS not later then Th (=3D< 500ms):
>   SAE J1939-21 2001 - C.1 Connection Mode Data Transfer
>   The responder station then issues a TP.CM_CTS indicating that it wants
>   to hold the connection open but cannot receive any packets right now. =
A
>   maximum of 500 ms later it must send another TP.CM_CTS message to hold
>   the connection.
>=20
> But we care only about T4 value on our side.
  Will add!>
>> +		j1939_tp_set_rxtimeout(session, J1939_CTS_HOLD_TIMEOUT_MS);
>=20
>=20
>> +		netdev_dbg(session->priv->ndev, "%s: 0x%p received CTS hold\n", __fu=
nc__, session);
>> +		return;
>>   	}
>>  =20
>>   	if (session->skcb.addr.type =3D=3D J1939_ETP)
>> @@ -1457,7 +1473,11 @@ j1939_xtp_rx_cts_one(struct j1939_session *sessi=
on, struct sk_buff *skb)
>>   	else if (dat[1] > session->pkt.block /* 0xff for etp */)
>>   		goto out_session_cancel;
>>  =20
>> -	/* set packet counters only when not CTS(0) */
>> +	if (session->pkt.tx_acked >=3D pkt) {
>> +		err =3D J1939_XTP_ABORT_DUP_SEQ;
>> +		goto out_session_cancel;
>> +	}
>> +
>>   	session->pkt.tx_acked =3D pkt - 1;
>>   	j1939_session_skb_drop_old(session);
>>   	session->pkt.last =3D session->pkt.tx_acked + dat[1];
>> @@ -1467,19 +1487,13 @@ j1939_xtp_rx_cts_one(struct j1939_session *sess=
ion, struct sk_buff *skb)
>>   	/* TODO: do not set tx here, do it in txtimer */
>>   	session->pkt.tx =3D session->pkt.tx_acked;
>>  =20
>> -	session->last_cmd =3D dat[0];
>> -	if (dat[1]) {
>> -		j1939_tp_set_rxtimeout(session, 1250);
>> -		if (session->transmission) {
>> -			if (session->pkt.tx_acked)
>> -				j1939_sk_errqueue(session,
>> -						  J1939_ERRQUEUE_TX_SCHED);
>> -			j1939_session_txtimer_cancel(session);
>> -			j1939_tp_schedule_txtimer(session, 0);
>> -		}
>> -	} else {
>> -		/* CTS(0) */
>> -		j1939_tp_set_rxtimeout(session, 550);
>=20
> Now I understand where 550 comes from. It is Th + 50. But you are
> correct, we need to use T4 here.
Exactly, the Th is a receiver side performance requirement. But it is a
quite confusing standard. It's very easy to get confused.>
>> +	j1939_tp_set_rxtimeout(session, 1250);
>> +	if (session->transmission) {
>> +		if (session->pkt.tx_acked)
>> +			j1939_sk_errqueue(session,
>> +						J1939_ERRQUEUE_TX_SCHED);
>> +		j1939_session_txtimer_cancel(session);
>> +		j1939_tp_schedule_txtimer(session, 0);
>>   	}
>>   	return;
>>  =20
>> diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing=
/selftests/net/can/.gitignore
>> +
>> +/* Segemented payload sent by the J1939 socket*/
>> +const uint8_t J1939_PAYLOAD[]	=3D {0x00, 0x01, 0x02, 0x03, 0x04, 0x05,=
 0x06, 0x07, 0x08, 0x09};
>=20
> can you please remove tabs or extra spaces between [] and =3D
> const uint8_t J1939_PAYLOAD[] =3D {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0=
x06, 0x07, 0x08, 0x09};
>=20
Sure!

>> +
>> +/* Expected RTS payload */
>> +const uint8_t RTS_PAYLOAD[]					=3D {0x10, 0x0A, 0x00, 0x02, 0x02, 0x0=
0, 0xAB, 0x00};
>> +/* Hold payload to be sent by raw socket */
>> +const uint8_t HOLD_PAYLOAD[]				=3D {0x11, 0x00, 0xFF, 0xFF, 0xFF, 0x0=
0, 0xAB, 0x00};
>> +/* CTS to send to only allow for the transmission of one data frame */
>> +const uint8_t CTS_1_FRAME_PAYLOAD[]			=3D {0x11, 0x01, 0x01, 0xFF, 0xF=
F, 0x00, 0xAB, 0x00};
>> +/* Resume payload to resume from connection which has been held direct=
ly after RTS*/
>> +const uint8_t RESUME_IMMEDIATE_PAYLOAD[]	=3D {0x11, 0x02, 0x01, 0xFF, =
0xFF, 0x00, 0xAB, 0x00};
>> +/* Resume payload to resume session which has been held after first da=
ta frame */
>> +const uint8_t RESUME_PAYLOAD[]				=3D {0x11, 0x01, 0x02, 0xFF, 0xFF, 0=
x00, 0xAB, 0x00};
>> +/* Data payloads */
>> +const uint8_t DATA_1_PAYLOAD[]				=3D {0x01, 0x00, 0x01, 0x02, 0x03, 0=
x04, 0x05, 0x06};
>> +const uint8_t DATA_2_PAYLOAD[]				=3D {0x02, 0x07, 0x08, 0x09, 0xFF, 0=
xFF, 0xFF, 0xFF};
>> +
>> +/* EOMA payload to cleanup session */
>> +const uint8_t EOMA_PAYLOAD[]				=3D {0x13, 0x0A, 0x00, 0x02, 0xFF, 0x0=
0, 0xAB, 0x00};
>> +
>> +/* Timeout payload sent on connection timeout */
>> +const uint8_t ABORT_TIMEOUT_PAYLOAD[]		=3D {0xFF, 0x03, 0xFF, 0xFF, 0x=
FF, 0x00, 0xAB, 0x00};
>> +char CANIF[IFNAMSIZ];
>> +
>> +static int recv_payload(int sock, const uint8_t *payload, size_t len)
>> +{
>> +	struct can_frame rx_frame =3D {};
>> +
>> +	if (recv(sock, &rx_frame, sizeof(rx_frame), 0) < 0) {
>=20
> recv will block until we receive something, it will be not good if test =
fails
> and nothing is send. Probably something like this:
>=20
> static int recv_payload_timeout(int sock, const uint8_t *payload, size_t=
 len, int timeout_ms)
> {
> 	struct can_frame rx_frame =3D {};
> 	struct pollfd pfd =3D {
> 		.fd =3D sock,
> 		.events =3D POLLIN,
> 	};
> 	int ret;
>=20
> 	/* Wait for data to be ready to read, up to timeout_ms */
> 	ret =3D poll(&pfd, 1, timeout_ms);
> 	if (ret < 0) {
> 		perror("poll failed");
> 		return 1;
> 	}
> =09
> 	if (ret =3D=3D 0) {
> 		fprintf(stderr, "timeout waiting for can raw frame\n");
> 		return 1;
> 	}
>=20
> 	/* Socket is readable, recv will not block */
> 	if (recv(sock, &rx_frame, sizeof(rx_frame), 0) < 0) {
> 		perror("failed to recv can raw frame");
> 		return 1;
> 	}
>=20
> 	if (rx_frame.len !=3D len) {
> 		fprintf(stderr, "received data length does not match expected value\n"=
);
> 		return 1;
> 	}
>=20
> 	if (memcmp(rx_frame.data, payload, len)) {
> 		fprintf(stderr, "received data does not match expected value\n");
> 		return 1;
> 	}
>=20
> 	return 0;
> }
>=20
My original way to avoid this problem was setting SO_RCVTIMEO on the raw=
=20
socket but I can use poll instead. That would also have the advantage=20
that you could change the timeout more easily. Will do!

> ....
>=20
>> +/* Test timeout after not resuming hold */
>> +TEST_F(can_env, test_hold_timeout)
>> +{
>> +	struct can_frame tx_frame =3D {
>> +		.can_id =3D RECEIVER_TP_CM_ID,
>> +		.len =3D 8,
>> +	};
>> +
>> +	memcpy(tx_frame.data, HOLD_PAYLOAD, sizeof(HOLD_PAYLOAD));
>> +	int res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOA=
D), 0);
>> +
>> +	ASSERT_GT(res, 0)
>> +		TH_LOG("failed to send j1939 payload: %d", errno);
>> +
>> +	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD)=
);
>> +	ASSERT_EQ(res, 0)
>> +		TH_LOG("Failed to receive RTS as expeceted");
>> +
>> +	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
>> +	ASSERT_GT(res, 0)
>> +		TH_LOG("failed to send hold with raw sock: %d", errno);
>> +
>> +	/* Wait for 1100 ms and receive the abort due to CTS hold timeout.
>> +	 * The actual timeout is 1050ms but with this test setup there is no =
point
>> +	 * in trying to be this exact.
>> +	 */
>> +	usleep(1100 * 1000);
>> +
>> +	res =3D recv_payload(self->raw_sock, ABORT_TIMEOUT_PAYLOAD, sizeof(AB=
ORT_TIMEOUT_PAYLOAD));
>> +	ASSERT_EQ(res, 0)
>> +		TH_LOG("Failed to receive abort as expeceted");
>> +}
>  =20
> This test may potentially have random fails due to CI system load.
> May be:
>=20
> #define DEFAULT_RECV_TIMEOUT_MS 2000
>=20
> static int recv_payload(int sock, const uint8_t *payload, size_t len)
> {
> 	return recv_payload_timeout(sock, payload, len, DEFAULT_RECV_TIMEOUT_MS=
);
> }
>=20
> /* Test timeout after not resuming hold */
> TEST_F(can_env, test_hold_timeout)
> {
> 	struct can_frame tx_frame =3D {
> 		.can_id =3D RECEIVER_TP_CM_ID,
> 		.len =3D 8,
> 	};
> 	struct timespec start, end;
> 	long elapsed_ms;
> 	int res;
>=20
> 	memcpy(tx_frame.data, HOLD_PAYLOAD, sizeof(HOLD_PAYLOAD));
> 	res =3D send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD), 0)=
;
> 	ASSERT_GT(res, 0)
> 		TH_LOG("failed to send j1939 payload: %d", errno);
>=20
> 	res =3D recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
> 	ASSERT_EQ(res, 0)
> 		TH_LOG("Failed to receive RTS as expected");
>=20
> 	res =3D send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
> 	ASSERT_GT(res, 0)
> 		TH_LOG("failed to send hold with raw sock: %d", errno);
>=20
> 	/* Record start time */
> 	clock_gettime(CLOCK_MONOTONIC, &start);
>=20
> 	/*
> 	 * Receive with a timeout larger than the expected 1050ms J1939 timeout=
.
> 	 * 2000ms provides plenty of headroom for CI without hanging indefinite=
ly.
> 	 */
> 	res =3D recv_payload_timeout(self->raw_sock, ABORT_TIMEOUT_PAYLOAD,
> 				   sizeof(ABORT_TIMEOUT_PAYLOAD), 2000);
> =09
> 	ASSERT_EQ(res, 0)
> 		TH_LOG("Failed to receive abort as expected");
>=20
> 	/* Record end time and calculate elapsed milliseconds */
> 	clock_gettime(CLOCK_MONOTONIC, &end);
> 	elapsed_ms =3D (end.tv_sec - start.tv_sec) * 1000 +
> 		     (end.tv_nsec - start.tv_nsec) / 1000000;
>=20
> 	/*
> 	 * The actual timeout is 1050ms. We define an acceptable window
> 	 * to account for CI scheduling variations.
> 	 */
> 	ASSERT_GE(elapsed_ms, 1000)
> 		TH_LOG("Abort received too early: %ld ms", elapsed_ms);
> 	ASSERT_LE(elapsed_ms, 1500)
> 		TH_LOG("Abort received too late: %ld ms", elapsed_ms);
> }
>=20
>=20
Perfect, thank you!



