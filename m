Return-Path: <linux-can+bounces-7640-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DcbD2ByCWpJaQQAu9opvQ
	(envelope-from <linux-can+bounces-7640-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 09:46:40 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F83055FC18
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 09:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5989E3003835
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A7930C154;
	Sun, 17 May 2026 07:46:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3354E31618C
	for <linux-can@vger.kernel.org>; Sun, 17 May 2026 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779003995; cv=none; b=M1yM2OL8lpLIgG4rA9Hw3vLfVaS8ScIDCr3SWqZs7+sCp1TKp89BfVrIGYGFj3WYIiwkZ0fXuC0E6zFyhXlwqlrj2Ug6/cUarZqUY6NtxqxpafBMv9AgjXXv53bEHLXfhYo18vozxM22e3j1bW/eD4T8d4k8KDY0bZBeApaxK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779003995; c=relaxed/simple;
	bh=gH10xmveKqYweZBiRDFivBZGSYyPk9kf7S96ibioE70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0JBOMASZPB8zh73p/VWmXrB6NQ7yCwEZj61vVy9A2NS7ZDUWadUJeVkNy7IegboiS9rbFNdEoC3gAz/PpE2ECr8d+krrE/CAnMlX9sXtppEMDCSLYvlu8jLog82TRo7QzJS3ojpVNthShdpoFtEaCvUv2Db8OxKtYKLqgtpgQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1wOWCd-0006bX-LQ; Sun, 17 May 2026 09:46:23 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wOWCc-000OTj-2T;
	Sun, 17 May 2026 09:46:23 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wOWCd-0000000CRYb-0ogE;
	Sun, 17 May 2026 09:46:23 +0200
Date: Sun, 17 May 2026 09:46:23 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Alexander =?utf-8?B?SMO2bHps?= <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	linux-can@vger.kernel.org
Subject: Re: [PATCH v2] Fix J1939 implementation not handling holds correctly
Message-ID: <aglyT74qHffw0vRl@pengutronix.de>
References: <20260516143644.139561-1-alexander.hoelzl@gmx.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260516143644.139561-1-alexander.hoelzl@gmx.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
X-Rspamd-Queue-Id: 3F83055FC18
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmx.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7640-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[o.rempel@pengutronix.de,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

Hi Alexander,

On Sat, May 16, 2026 at 04:35:25PM +0200, Alexander Hölzl wrote:
> The J1939 protocol allows the receiver of directed segemented messages
> to hold the data transfer. The kernel implementation did not handle hold
> messages correctly was not able to resume from a hold.
> 
> Fix J1939 RTS/CTS session not being able to resume from hold.
> Replace hardcoded timeout with define.
> Add CTS hold behavior tests.
> 
> Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
> ---
> Compared to the last patch I removed all of the todo comments I had
> still had in the code. I will implement hold notification in the error
> queue in different patch.
> 
> I replaced the hardcoded hold timeout with a define. I can replace the
> other hardcoded timeouts in a different patch if you want me to, but
> for now I only touched code related to the holds.
> I also added a helper function to check if a CTS is a hold.
> 
> I also added a baseline test case as you wanted. Altough in the future
> it should probably moved to another file which specfically tests normal
> RTS/CTS behavior.
> 
> Also addressed all the comments Sashiko had on the test file and I'm
> also now sending an EOMA in the test as without it between every test
> there was a 1250ms wait until the session timed out...

Nice!

>  net/can/j1939/transport.c                     |  48 ++-

Please split fix and testing patches. Otherwise reverting it for testing
will break testing (at least it will make things a bit more
complicated).

>  tools/testing/selftests/net/can/.gitignore    |   1 +
>  tools/testing/selftests/net/can/Makefile      |   8 +-
>  tools/testing/selftests/net/can/config        |   1 +
>  .../testing/selftests/net/can/test_cts_hold.c | 322 ++++++++++++++++++
>  .../selftests/net/can/test_cts_hold.sh        |  45 +++
>  6 files changed, 406 insertions(+), 19 deletions(-)
>  create mode 100644 tools/testing/selftests/net/can/test_cts_hold.c
>  create mode 100755 tools/testing/selftests/net/can/test_cts_hold.sh


> +/* Time until session invalidation upon reception of a hold message.
> + * Corresponds to T4 in the specification.

I would add here documentation references, it would help another me in
two yars to understand things :)
ISO 11783-3 2018 - 5.10.3.5 Connection closure
SAE J1939-21 2001 - 5.10.2.4 Connection Closure

You can update version if you have more recent variants.

> + */
> +#define J1939_CTS_HOLD_TIMEOUT_MS 1050
> +
>  enum j1939_xtp_abort {
>  	J1939_XTP_NO_ABORT = 0,
>  	J1939_XTP_ABORT_BUSY = 1,
> @@ -1428,6 +1433,11 @@ j1939_xtp_rx_eoma(struct j1939_priv *priv, struct sk_buff *skb,
>  	j1939_session_put(session);
>  }
>  

Here comment:
SAE J1939-21 2001 - 5.10.2.4 Connection Closure
ISO 11783-3 2018 - 5.11.5.4 Extended Connection Mode Clear To Send (ETP.CM_CTS)

The number of packets to send can be set to 0 to hold the connection

> +static inline bool j1939_cts_is_hold(const struct sk_buff *skb)
> +{
> +	return (!skb->data[1]);
> +}
> +
>  static void
>  j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
>  {
> @@ -1442,9 +1452,15 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
>  
>  	netdev_dbg(session->priv->ndev, "%s: 0x%p\n", __func__, session);
>  
> -	if (session->last_cmd == dat[0]) {
> -		err = J1939_XTP_ABORT_DUP_SEQ;
> -		goto out_session_cancel;

We need to document old and new sanity check behavior in the commit
message.

Before this change it protects only against a flood of CTS where the
linux stack didn't managed to start sending the data - less probable
scenario. And it prevents valid CTS hold support - most probable
scenario.

After the patch it allows to sende multiple CTS including CTS(0), but
prevents requesting the already transferred and acked packets. So, the
kernel will abort immediately instead of going in to timeout.

> +	session->last_cmd = dat[0];
> +
> +	if (j1939_cts_is_hold(skb)) {
> +		if (session->transmission)
> +			j1939_session_txtimer_cancel(session);
> +

Here we need a comment:
The originator should abort the session after T4 (=< 1050ms):
 SAE J1939-21 2001 - 5.10.2.4 Connection Closure
 a lack of a CTS for more than (T4) seconds after a CTS (0) message to
 "hold the connection open" will all cause a connection closure to occur.

The receiver should send followup CTS not later then Th (=< 500ms):
 SAE J1939-21 2001 - C.1 Connection Mode Data Transfer
 The responder station then issues a TP.CM_CTS indicating that it wants
 to hold the connection open but cannot receive any packets right now. A
 maximum of 500 ms later it must send another TP.CM_CTS message to hold
 the connection.

But we care only about T4 value on our side.

> +		j1939_tp_set_rxtimeout(session, J1939_CTS_HOLD_TIMEOUT_MS);


> +		netdev_dbg(session->priv->ndev, "%s: 0x%p received CTS hold\n", __func__, session);
> +		return;
>  	}
>  
>  	if (session->skcb.addr.type == J1939_ETP)
> @@ -1457,7 +1473,11 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
>  	else if (dat[1] > session->pkt.block /* 0xff for etp */)
>  		goto out_session_cancel;
>  
> -	/* set packet counters only when not CTS(0) */
> +	if (session->pkt.tx_acked >= pkt) {
> +		err = J1939_XTP_ABORT_DUP_SEQ;
> +		goto out_session_cancel;
> +	}
> +
>  	session->pkt.tx_acked = pkt - 1;
>  	j1939_session_skb_drop_old(session);
>  	session->pkt.last = session->pkt.tx_acked + dat[1];
> @@ -1467,19 +1487,13 @@ j1939_xtp_rx_cts_one(struct j1939_session *session, struct sk_buff *skb)
>  	/* TODO: do not set tx here, do it in txtimer */
>  	session->pkt.tx = session->pkt.tx_acked;
>  
> -	session->last_cmd = dat[0];
> -	if (dat[1]) {
> -		j1939_tp_set_rxtimeout(session, 1250);
> -		if (session->transmission) {
> -			if (session->pkt.tx_acked)
> -				j1939_sk_errqueue(session,
> -						  J1939_ERRQUEUE_TX_SCHED);
> -			j1939_session_txtimer_cancel(session);
> -			j1939_tp_schedule_txtimer(session, 0);
> -		}
> -	} else {
> -		/* CTS(0) */
> -		j1939_tp_set_rxtimeout(session, 550);

Now I understand where 550 comes from. It is Th + 50. But you are
correct, we need to use T4 here.

> +	j1939_tp_set_rxtimeout(session, 1250);
> +	if (session->transmission) {
> +		if (session->pkt.tx_acked)
> +			j1939_sk_errqueue(session,
> +						J1939_ERRQUEUE_TX_SCHED);
> +		j1939_session_txtimer_cancel(session);
> +		j1939_tp_schedule_txtimer(session, 0);
>  	}
>  	return;
>  
> diff --git a/tools/testing/selftests/net/can/.gitignore b/tools/testing/selftests/net/can/.gitignore
> +
> +/* Segemented payload sent by the J1939 socket*/
> +const uint8_t J1939_PAYLOAD[]	= {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09};

can you please remove tabs or extra spaces between [] and =
const uint8_t J1939_PAYLOAD[] = {0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09};

> +
> +/* Expected RTS payload */
> +const uint8_t RTS_PAYLOAD[]					= {0x10, 0x0A, 0x00, 0x02, 0x02, 0x00, 0xAB, 0x00};
> +/* Hold payload to be sent by raw socket */
> +const uint8_t HOLD_PAYLOAD[]				= {0x11, 0x00, 0xFF, 0xFF, 0xFF, 0x00, 0xAB, 0x00};
> +/* CTS to send to only allow for the transmission of one data frame */
> +const uint8_t CTS_1_FRAME_PAYLOAD[]			= {0x11, 0x01, 0x01, 0xFF, 0xFF, 0x00, 0xAB, 0x00};
> +/* Resume payload to resume from connection which has been held directly after RTS*/
> +const uint8_t RESUME_IMMEDIATE_PAYLOAD[]	= {0x11, 0x02, 0x01, 0xFF, 0xFF, 0x00, 0xAB, 0x00};
> +/* Resume payload to resume session which has been held after first data frame */
> +const uint8_t RESUME_PAYLOAD[]				= {0x11, 0x01, 0x02, 0xFF, 0xFF, 0x00, 0xAB, 0x00};
> +/* Data payloads */
> +const uint8_t DATA_1_PAYLOAD[]				= {0x01, 0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06};
> +const uint8_t DATA_2_PAYLOAD[]				= {0x02, 0x07, 0x08, 0x09, 0xFF, 0xFF, 0xFF, 0xFF};
> +
> +/* EOMA payload to cleanup session */
> +const uint8_t EOMA_PAYLOAD[]				= {0x13, 0x0A, 0x00, 0x02, 0xFF, 0x00, 0xAB, 0x00};
> +
> +/* Timeout payload sent on connection timeout */
> +const uint8_t ABORT_TIMEOUT_PAYLOAD[]		= {0xFF, 0x03, 0xFF, 0xFF, 0xFF, 0x00, 0xAB, 0x00};
> +char CANIF[IFNAMSIZ];
> +
> +static int recv_payload(int sock, const uint8_t *payload, size_t len)
> +{
> +	struct can_frame rx_frame = {};
> +
> +	if (recv(sock, &rx_frame, sizeof(rx_frame), 0) < 0) {

recv will block until we receive something, it will be not good if test fails
and nothing is send. Probably something like this:

static int recv_payload_timeout(int sock, const uint8_t *payload, size_t len, int timeout_ms)
{
	struct can_frame rx_frame = {};
	struct pollfd pfd = {
		.fd = sock,
		.events = POLLIN,
	};
	int ret;

	/* Wait for data to be ready to read, up to timeout_ms */
	ret = poll(&pfd, 1, timeout_ms);
	if (ret < 0) {
		perror("poll failed");
		return 1;
	}
	
	if (ret == 0) {
		fprintf(stderr, "timeout waiting for can raw frame\n");
		return 1;
	}

	/* Socket is readable, recv will not block */
	if (recv(sock, &rx_frame, sizeof(rx_frame), 0) < 0) {
		perror("failed to recv can raw frame");
		return 1;
	}

	if (rx_frame.len != len) {
		fprintf(stderr, "received data length does not match expected value\n");
		return 1;
	}

	if (memcmp(rx_frame.data, payload, len)) {
		fprintf(stderr, "received data does not match expected value\n");
		return 1;
	}

	return 0;
}

....

> +/* Test timeout after not resuming hold */
> +TEST_F(can_env, test_hold_timeout)
> +{
> +	struct can_frame tx_frame = {
> +		.can_id = RECEIVER_TP_CM_ID,
> +		.len = 8,
> +	};
> +
> +	memcpy(tx_frame.data, HOLD_PAYLOAD, sizeof(HOLD_PAYLOAD));
> +	int res = send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD), 0);
> +
> +	ASSERT_GT(res, 0)
> +		TH_LOG("failed to send j1939 payload: %d", errno);
> +
> +	res = recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
> +	ASSERT_EQ(res, 0)
> +		TH_LOG("Failed to receive RTS as expeceted");
> +
> +	res = send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
> +	ASSERT_GT(res, 0)
> +		TH_LOG("failed to send hold with raw sock: %d", errno);
> +
> +	/* Wait for 1100 ms and receive the abort due to CTS hold timeout.
> +	 * The actual timeout is 1050ms but with this test setup there is no point
> +	 * in trying to be this exact.
> +	 */
> +	usleep(1100 * 1000);
> +
> +	res = recv_payload(self->raw_sock, ABORT_TIMEOUT_PAYLOAD, sizeof(ABORT_TIMEOUT_PAYLOAD));
> +	ASSERT_EQ(res, 0)
> +		TH_LOG("Failed to receive abort as expeceted");
> +}
 
This test may potentially have random fails due to CI system load.
May be:

#define DEFAULT_RECV_TIMEOUT_MS 2000

static int recv_payload(int sock, const uint8_t *payload, size_t len)
{
	return recv_payload_timeout(sock, payload, len, DEFAULT_RECV_TIMEOUT_MS);
}

/* Test timeout after not resuming hold */
TEST_F(can_env, test_hold_timeout)
{
	struct can_frame tx_frame = {
		.can_id = RECEIVER_TP_CM_ID,
		.len = 8,
	};
	struct timespec start, end;
	long elapsed_ms;
	int res;

	memcpy(tx_frame.data, HOLD_PAYLOAD, sizeof(HOLD_PAYLOAD));
	res = send(self->j1939_sock, J1939_PAYLOAD, sizeof(J1939_PAYLOAD), 0);
	ASSERT_GT(res, 0)
		TH_LOG("failed to send j1939 payload: %d", errno);

	res = recv_payload(self->raw_sock, RTS_PAYLOAD, sizeof(RTS_PAYLOAD));
	ASSERT_EQ(res, 0)
		TH_LOG("Failed to receive RTS as expected");

	res = send(self->raw_sock, &tx_frame, sizeof(tx_frame), 0);
	ASSERT_GT(res, 0)
		TH_LOG("failed to send hold with raw sock: %d", errno);

	/* Record start time */
	clock_gettime(CLOCK_MONOTONIC, &start);

	/* 
	 * Receive with a timeout larger than the expected 1050ms J1939 timeout.
	 * 2000ms provides plenty of headroom for CI without hanging indefinitely.
	 */
	res = recv_payload_timeout(self->raw_sock, ABORT_TIMEOUT_PAYLOAD, 
				   sizeof(ABORT_TIMEOUT_PAYLOAD), 2000);
	
	ASSERT_EQ(res, 0)
		TH_LOG("Failed to receive abort as expected");

	/* Record end time and calculate elapsed milliseconds */
	clock_gettime(CLOCK_MONOTONIC, &end);
	elapsed_ms = (end.tv_sec - start.tv_sec) * 1000 + 
		     (end.tv_nsec - start.tv_nsec) / 1000000;

	/* 
	 * The actual timeout is 1050ms. We define an acceptable window 
	 * to account for CI scheduling variations.
	 */
	ASSERT_GE(elapsed_ms, 1000)
		TH_LOG("Abort received too early: %ld ms", elapsed_ms);
	ASSERT_LE(elapsed_ms, 1500)
		TH_LOG("Abort received too late: %ld ms", elapsed_ms);
}


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

