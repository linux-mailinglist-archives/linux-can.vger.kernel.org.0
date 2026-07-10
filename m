Return-Path: <linux-can+bounces-8279-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CJZRIhzPUGpt5QIAu9opvQ
	(envelope-from <linux-can+bounces-8279-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:53:16 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C12F4739DD2
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 12:53:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AhaJ0eTO;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8279-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8279-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 358773083160
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 10:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0576741227D;
	Fri, 10 Jul 2026 10:47:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A7B411682
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 10:47:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680452; cv=none; b=El6wJ1FT8DUfCIVnvY0C93JkqTxv9hkFDFaod4TzPhPlrk2ZI9DryfRA3JUBcVkWVXgnpItRWbSPak8dB30efN9RY7dS3OKb3i4q1GyHL+QcS/odkOjJqlFMzkSfngjFXGP8vbDju46o8BrYhrxFS9F+wsEGyKFwM4fdjXRbWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680452; c=relaxed/simple;
	bh=FOx7g8tf0nIi4und8pZcaDiNS7sJeSR4RQi1lC+GLIo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WUJTcmJy1miO2oYZqwlG8KdxaO9sDbhizDanswJ+SI5solvNY5YqVMnM38wr9/+/2R/YrkisMs3+ig7CMHJ+D98viroSG9ejFeqIR1oDmi5ZQ2imX6+2vdalVdIq4eoMbSejr7KKzS9hE3jm9OGS3HPWMUuGE1cu8Io1RVwd02c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhaJ0eTO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD691F000E9;
	Fri, 10 Jul 2026 10:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783680447;
	bh=0H33BPE+BRGZw7NC32337s2MGb4dOa3g+ZnSApX9ssg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AhaJ0eTObRPFpCMdRAEde0UsZu+ggVuwg8fpfDwpOaAWz/dl+BWvIu0L1AcKfFcc+
	 TMGbRdgOQ/3mHEpkxl8gzbuOo8F+a9JZ38SgxZSG0Q8fy+m9TvHSUhaRWCHpHCV9QF
	 8vqBAlEJqCZuhDsSRhmwBdl7wkeLWUHmhC+h1sWaYYunvA1qU9OUryy8t9Zp08Mos7
	 Tn1iaQCH46Ab8fpmb9YSPA/hjbniT9H9/cGXPcGnlBInf/y+2DTppRIVKQ/6mn40MJ
	 cLz9bZ70JUHYyUE+zsvjZTMOTV+sygaHQWZNB81oUDF2RYiLN0qU4qmFHs88TNA8Ry
	 k3J9RvYUSnXPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: esd_usb: kill anchored URBs before freeing
 netdevs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: linux-can@vger.kernel.org, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260709104620.133765-1-fanwu01@zju.edu.cn>
References: <20260709104620.133765-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 10:47:26 +0000
Message-Id: <20260710104726.EAD691F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8279-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lists.linux.dev:replyto,sashiko.dev:url,zju.edu.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fanwu01@zju.edu.cn,m:linux-can@vger.kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C12F4739DD2

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Malicious USB devices or normal operations can trigger a NULL poin=
ter dereference if `esd_usb_probe_one_net()` fails for a network interface.
- [High] A zero-length message from the USB device causes an infinite loop =
in the RX completion handler, leading to a softirq CPU lockup.
- [High] The driver parses and copies USB message payload into CAN frames b=
efore validating that the message length fits within the received USB data =
or allocated buffer.
- [High] Double-free and Use-After-Free of echo_skb during device teardown =
due to missing URB cancellation in `ndo_stop`.
- [Medium] If `usb_submit_urb()` fails in `esd_usb_start_xmit()`, the alloc=
ated TX context is never released, leading to a permanent depletion of TX c=
ontexts.
--

--- Patch [1]: [PATCH net] can: esd_usb: kill anchored URBs before freeing =
netdevs ---
commit f2616c0b84f4389121d1ebf004051cb8242711c9
Author: Fan Wu <fanwu01@zju.edu.cn>

can: esd_usb: kill anchored URBs before freeing netdevs

This commit reorders the teardown sequence in esd_usb_disconnect so that
anchored URBs are killed before the CAN netdevs are freed. This prevents a
use-after-free where unlink_all_urbs would otherwise dereference a
previously freed network device structure to cancel active TX jobs.

> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index d257440fa01ff..f41d4a0d140f7 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c
> @@ -1390,10 +1390,13 @@ static void esd_usb_disconnect(struct usb_interfa=
ce *intf)
>  				netdev =3D dev->nets[i]->netdev;
>  				netdev_info(netdev, "unregister\n");
>  				unregister_netdev(netdev);
> -				free_candev(netdev);
>  			}
>  		}
>  		unlink_all_urbs(dev);
> +		for (i =3D 0; i < dev->net_count; i++) {
> +			if (dev->nets[i])
> +				free_candev(dev->nets[i]->netdev);
> +		}
>  		kfree(dev);
>  	}
>  }

[Severity: High]
This isn't a bug introduced by this patch, but if esd_usb_probe_one_net
fails during initialization, could it lead to a NULL pointer dereference
later?

In esd_usb_probe:
	for (i =3D 0; i < dev->net_count; i++)
		esd_usb_probe_one_net(intf, i);

If the probe fails for a specific network interface, dev->nets[i] remains
NULL because the error is ignored. If a USB device sends a message for that
uninitialized network index, is it safe to pass it directly to
esd_usb_rx_can_msg?

In esd_usb_read_bulk_callback:
		case ESD_USB_CMD_CAN_RX:
			if (msg->rx.net >=3D dev->net_count) {
				dev_err(dev->udev->dev.parent, "format error\n");
				break;
			}

			esd_usb_rx_can_msg(dev->nets[msg->rx.net], msg);

[Severity: High]
This is a pre-existing issue, but does a zero-length message from the USB
device cause an infinite loop in the RX completion handler?

In esd_usb_read_bulk_callback:
		pos +=3D msg->hdr.len * sizeof(u32); /* convert to # of bytes */

		if (pos > urb->actual_length) {
			dev_err(dev->udev->dev.parent, "format error\n");
			break;
		}

If a local USB device sets msg->hdr.len =3D 0, pos will not advance,
potentially causing the loop condition pos < urb->actual_length to run
infinitely and lock up the CPU in softirq context.

[Severity: High]
This is a pre-existing issue, but does the driver parse the USB message
payload before ensuring it fits within the received buffer?

In esd_usb_read_bulk_callback:
	while (pos < urb->actual_length) {
		union esd_usb_msg *msg;

		msg =3D (union esd_usb_msg *)(urb->transfer_buffer + pos);

		switch (msg->hdr.cmd) {
		case ESD_USB_CMD_CAN_RX:
// ...
			esd_usb_rx_can_msg(dev->nets[msg->rx.net], msg);

The message fields seem to be parsed and passed to handlers like
esd_usb_rx_can_msg which read from the buffer, but the boundary check
evaluating pos > urb->actual_length happens at the end of the loop. Can this
lead to an out-of-bounds read if a message is positioned near the end of the
transfer buffer?

[Severity: High]
This is a pre-existing issue, but is there a potential double-free of
echo_skb during device teardown?

In esd_usb_close:
	priv->can.state =3D CAN_STATE_STOPPED;

	netif_stop_queue(netdev);

	close_candev(netdev);

	return err;

Since close_candev flushes the echo_skb array without locking, and
esd_usb_close does not appear to kill active URBs before this point, could
a concurrent TX URB completion fire in softirq?

In esd_usb_tx_done_msg:
		stats->tx_errors++;
		can_free_echo_skb(netdev, context->echo_index, NULL);

If both paths access and free the exact same echo_skb concurrently, this
might lead to memory corruption.

[Severity: Medium]
This is a pre-existing issue, but if usb_submit_urb fails in
esd_usb_start_xmit, does it permanently leak a TX context?

In esd_usb_start_xmit:
	err =3D usb_submit_urb(urb, GFP_ATOMIC);
	if (err) {
		can_free_echo_skb(netdev, context->echo_index, NULL);

		atomic_dec(&priv->active_tx_jobs);
		usb_unanchor_urb(urb);

The error path frees the echo_skb, but it appears to miss resetting
context->echo_index back to ESD_USB_MAX_TX_URBS. If this happens repeatedly
due to transient errors, could it permanently exhaust all 16 contexts and
stall network transmission?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709104620.1337=
65-1-fanwu01@zju.edu.cn?part=3D1

