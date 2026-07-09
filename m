Return-Path: <linux-can+bounces-8209-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BBnBBPnDT2o0oAIAu9opvQ
	(envelope-from <linux-can+bounces-8209-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 17:53:29 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC1A733248
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 17:53:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QOX9aPxK;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8209-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8209-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DC51309D4C1
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 15:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EFE421F17;
	Thu,  9 Jul 2026 15:45:16 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC589422556
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 15:45:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611916; cv=none; b=WEX3BCD0oyBDiAA0CVYKBKLFtHjlCyZlv90RK3eX848xXxszQDN+R7vfhldhncFRr+YDg3aHKL/Jc4E/qg3c7y5EGCQBvdd8lmKaV8IK/WMkHl9vlfeeflY2IzfQvhkRH1GORFrowVVufnELuqhVWQlTstsqCtuOc+aA7DwE/IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611916; c=relaxed/simple;
	bh=Uy5/aFNTupZm2f20r7gZHepQ99icGwvFsU34CA6G8GQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iR579MTdoWuZwErRffhEzRpZw2Kz952TFcA3bA2zZem/vYugnekHZ/HFFs34qxriIqCUbnx8do1qM73kTR85Ag+KXwAgEmqNREzW0LuAL6c94yD1VS115mp1Xr3VO82ux59R63gGiQHvg1NfwtRrJKWP7bNU6ony1rWqrGMJTWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QOX9aPxK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846831F000E9;
	Thu,  9 Jul 2026 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611914;
	bh=fotpBwHTxjg8BLDnsFXXftsOOyFS/TrfM2tvQg5x2/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QOX9aPxKXM1tq1Ks5ACTVvh0C4Tb/swBjEjr4BGFx0YhOValiGWVidzAzWTArwgHW
	 xw20SpYcOa3vPZO2UONZL0sJQqtCHpQAESsBu+/Lm4NAsgda0a1QzS8w18DYwbGtXE
	 9HfvWR7BKb3bpWuYd/tdk7swlh7IEJUXSsz1k+mwh0/r7kkdvjqs2QmyzYljittFl9
	 AwCjO5QX18rjs18P0i5OBcIKnpj0VQOwVzNERMnvtVl61bg3/PA52pwBF9MGEYenet
	 IRHV038E+bnWjM3q60LG1uPPz1Ce3+XBadoVpMX9boHcWuSWZwyNjNH/tVPgx9nXvC
	 Lr3WFczcYQdOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next] can: m_can: switch to rx-offload
 implementation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260709-m_can-rx-offload-v1-1-af3efa8e4272@pengutronix.de>
References: <20260709-m_can-rx-offload-v1-1-af3efa8e4272@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:45:14 +0000
Message-Id: <20260709154514.846831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8209-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4FC1A733248

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] Double counting of received packets and bytes, alongside a data ra=
ce on network statistics between HardIRQ and SoftIRQ contexts.
- [High] Processing RX frames directly in hardirq with a strict, non-replen=
ishable quota can leave packets stranded indefinitely in the hardware FIFO.
- [Low] The napi_struct is no longer used but was left in struct m_can_clas=
sdev.

Pre-existing issues:
- [High] The driver teardown path uses the non-blocking `hrtimer_try_to_can=
cel()` to stop the polling/coalescing timer, leading to unclocked hardware =
accesses and Use-After-Free vulnerabilities.
- [High] The teardown sequence in m_can_close leaks socket buffers and crea=
tes a guaranteed NULL pointer dereference when flushing the transmission wo=
rkqueue.
- [High] Uninitialized stack variable `frame_len` corrupts Byte Queue Limit=
s (BQL) accounting.
--

--- Patch [1]: [PATCH can-next] can: m_can: switch to rx-offload implementa=
tion ---
commit 7f375f1ac288dad1360ddf2dd262a4c708abc626
Author: Marc Kleine-Budde <mkl@pengutronix.de>

can: m_can: switch to rx-offload implementation

This patch converts the m_can driver to unconditionally use rx-offload
for all devices, calling m_can_rx_handler() directly from the IRQ
handler instead of using NAPI.

> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index eb856547ae7df..8175b030257b4 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -530,26 +530,17 @@ static void m_can_clean(struct net_device *net)
[ ... ]
>  static void m_can_receive_skb(struct m_can_classdev *cdev,
>  			      struct sk_buff *skb,
>  			      u32 timestamp)
>  {
> -	if (cdev->is_peripheral) {
> -		struct net_device_stats *stats =3D &cdev->net->stats;
> -		int err;
> +	struct net_device_stats *stats =3D &cdev->net->stats;
> +	int err;
> =20
> -		err =3D can_rx_offload_queue_timestamp(&cdev->offload, skb,
> -						     timestamp);
> -		if (err)
> -			stats->rx_fifo_errors++;
> -	} else {
> -		netif_receive_skb(skb);
> -	}
> +	err =3D can_rx_offload_queue_timestamp(&cdev->offload, skb,
> +					     timestamp);

[Severity: High]
Does this change introduce a data race and double counting for network stat=
s?

When the mmio devices are switched to use rx-offload, m_can_read_fifo()
manually increments the stats in hardirq context before calling
m_can_receive_skb():

m_can_read_fifo()
  stats->rx_bytes +=3D cf->len;
  stats->rx_packets++;
  m_can_receive_skb(..., skb, ...);

The SKB is then queued to the offload queue. When the rx-offload NAPI poll
runs in softirq context, it unconditionally increments the exact same
counters again:

can_rx_offload_napi_poll()
  stats->rx_packets++;
  stats->rx_bytes +=3D cf->len;

Does this completely inflate the RX statistics, as well as cause a concurre=
nt
data race between hardirq and softirq contexts updating dev->stats?

Additionally, wouldn't TX echo packets queued via
can_rx_offload_get_echo_skb_queue_timestamp() also be dequeued by the poll
routine, erroneously counting transmitted frames as RX packets?

[ ... ]
> @@ -1065,32 +1052,6 @@ static int m_can_rx_handler(struct net_device *dev=
, int quota, u32 irqstatus)
[ ... ]
>  static unsigned int m_can_tx_update_stats(struct m_can_classdev *cdev,
>  					  unsigned int msg_mark, u32 timestamp)
>  {
> @@ -1098,14 +1059,11 @@ static unsigned int m_can_tx_update_stats(struct =
m_can_classdev *cdev,
>  	struct net_device_stats *stats =3D &dev->stats;
>  	unsigned int frame_len;
> =20
> -	if (cdev->is_peripheral)
> -		stats->tx_bytes +=3D
> -			can_rx_offload_get_echo_skb_queue_timestamp(&cdev->offload,
> -								    msg_mark,
> -								    timestamp,
> -								    &frame_len);
> -	else
> -		stats->tx_bytes +=3D can_get_echo_skb(dev, msg_mark, &frame_len);
> +	stats->tx_bytes +=3D
> +		can_rx_offload_get_echo_skb_queue_timestamp(&cdev->offload,
> +							    msg_mark,
> +							    timestamp,
> +							    &frame_len);
> =20
>  	stats->tx_packets++;
> =20
>  	return frame_len;

[Severity: High]
This is a pre-existing issue, but is it possible for an uninitialized stack
variable to corrupt BQL accounting?

In m_can_tx_update_stats(), frame_len is passed by reference to
can_rx_offload_get_echo_skb_queue_timestamp(). If the echo SKB is missing
or invalid, the helper function returns 0 immediately and does not initiali=
ze
frame_len.

Will this return uninitialized stack garbage that gets passed to
netdev_completed_queue() in m_can_finish_tx(), potentially stalling the TX
queue by corrupting Byte Queue Limits accounting?

[ ... ]
> @@ -1265,21 +1223,10 @@ static int m_can_interrupt_handler(struct m_can_c=
lassdev *cdev)
[ ... ]
>  	if (ir & (IR_RF0N | IR_RF0W | IR_ERR_ALL_30X)) {
> -		cdev->irqstatus =3D ir;
> -		if (!cdev->is_peripheral) {
> -			m_can_disable_all_interrupts(cdev);
> -			napi_schedule(&cdev->napi);
> -		} else {
> -			ret =3D m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
> -			if (ret < 0)
> -				return ret;
> -		}
> +		ret =3D m_can_rx_handler(dev, NAPI_POLL_WEIGHT, ir);
> +		if (ret < 0)
> +			return ret;
>  	}

[Severity: High]
Could directly calling m_can_rx_handler() from the hardirq handler cause
packets to be stranded indefinitely?

The handler is now called with a strict quota of NAPI_POLL_WEIGHT. If the F=
IFO
contains more messages than the remaining quota (which can shrink if work_d=
one
is consumed by state errors), the read loop in m_can_do_rx_poll() breaks
early.

Because the IR_RF0N hardware interrupt is edge-triggered (only set when a n=
ew
message is written) and the NAPI automatic rescheduling is removed, will the
remaining packets sit in the hardware FIFO indefinitely until another frame
happens to arrive on the bus?

[ ... ]
> @@ -1846,11 +1791,10 @@ static int m_can_close(struct net_device *dev)
>  	if (cdev->is_peripheral) {
>  		destroy_workqueue(cdev->tx_wq);
>  		cdev->tx_wq =3D NULL;
> -		can_rx_offload_disable(&cdev->offload);
> -	} else {
> -		napi_disable(&cdev->napi);
>  	}

[Severity: High]
This is a pre-existing issue, but can the teardown sequence in m_can_close()
trigger a null pointer dereference?

During m_can_close(), m_can_clean() iterates through the tx_ops and sets
the skb pointers to NULL:

m_can_clean()
  cdev->tx_ops[i].skb =3D NULL;

Immediately after, destroy_workqueue(cdev->tx_wq) is called, which drains t=
he
queue and executes pending tasks. When the flushed m_can_tx_work_queue() ta=
sk
runs, it passes the nullified skb pointer to the tx handler:

m_can_tx_work_queue()
  struct sk_buff *skb =3D op->skb;
  m_can_tx_handler(cdev, skb);

Will this result in a null pointer dereference since the tx handler
unconditionally accesses skb->data? Also, is there a memory leak since
m_can_clean() clears the pointer without freeing the SKB memory?

[Severity: High]
This is a pre-existing issue, but does the teardown path safely stop the
polling timer?

Looking at the teardown sequence in m_can_close(), the interface is shut
down and interrupts are disabled, which relies on hrtimer_try_to_cancel() in
m_can_disable_all_interrupts():

m_can_close()
  m_can_stop()
    m_can_disable_all_interrupts()
      hrtimer_try_to_cancel(&cdev->hrtimer);

If the timer callback is actively running on another CPU,
hrtimer_try_to_cancel() returns -1 without waiting for the callback to fini=
sh.
The teardown path then continues to free data structures, disable hardware
clocks, and power off the PHY.

Could this lead to a use-after-free and synchronous bus fault when the
concurrently executing timer callback accesses unmapped or unclocked MMIO
regions?

Also, m_can_class_unregister() appears to lack explicit timer teardown, whi=
ch
might leave the timer active during module unload.

[ ... ]
> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
> index 4743342b2fba3..ca5833650dbfb 100644
> --- a/drivers/net/can/m_can/m_can.h
> +++ b/drivers/net/can/m_can/m_can.h
> @@ -96,7 +96,6 @@ struct m_can_classdev {
>  	const struct m_can_ops *ops;
> =20
>  	int version;
> -	u32 irqstatus;
> =20
>  	int pm_clock_support;
>  	int pm_wake_source;

[Severity: Low]
Is it intentional to keep the napi structure in m_can_classdev?

The patch removes all manual napi handling from the driver, but it looks li=
ke
struct napi_struct napi; is still present in the struct.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-m_can-rx-o=
ffload-v1-1-af3efa8e4272@pengutronix.de?part=3D1

