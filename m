Return-Path: <linux-can+bounces-591-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1F68BE514
	for <lists+linux-can@lfdr.de>; Tue,  7 May 2024 16:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D5711C23797
	for <lists+linux-can@lfdr.de>; Tue,  7 May 2024 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6196B15EFC5;
	Tue,  7 May 2024 14:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUAHuDB8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADC015E5A2;
	Tue,  7 May 2024 14:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090614; cv=none; b=Rh/Esz1Kg3EsfgVYJh11N+65J4TtscmTwjShFWhAQdrrS3p/3G66i9TPj02bBrwfIMlLA6XkMQrzpcAflFuDEifPaTYSNLvw6sdyfiPzmVeng/OsW3IX32EqnFed+Zgza9KUctZv8/pUY74fxJuKHpvIVbI5vCNECfXpXPYb3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090614; c=relaxed/simple;
	bh=4uyjjtLlvy23G4uGT8iYgbWNw67cUrp97HGC7a98lzs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UXp9PHn9Ggqti5dcoZ0fTeFf8q9NxY5wFO3CofJL7T3co3HIqNsKg97NRRJygzNQgA3iQl2keABEnlNndx/PJsMOs7tRHhjJ0VaswJpyHIX+Io2K45QuQr6la5dy6SJcSZcFdF0xYrMGLmYZnGO+sGLAjMBcOh7uFCiBOLOflRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUAHuDB8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41b782405bbso22166335e9.1;
        Tue, 07 May 2024 07:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715090611; x=1715695411; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ACRiFz5JMT7HATdqtB6Qwjpz19aIG/dJdFvDLMioqk4=;
        b=jUAHuDB8C2IvnGI+LejGLv2ZCa1Cxf+Jvt3LPY0ufErLQRCp2xjoQfji15ANOLzp/A
         xtVMmhS+womnTuKrlU6fbi0Z5kyUnESdV2qpm2iPw1xd7Q3HNCiguR4iM28jsT1lKr8G
         jPN7ehMVTTT13ZTIPSJ4qnxVSAdU7/fPwN/spaIcDIpNtLEtrxZ+WL4XJSnJrgZtNySB
         6qB1NVLR1aeRmhf/sszC4/l6JEhfH5RtdjfYggJWYalVEru+lueo5jCjgEXcfpaNEqdf
         GeVFvRoNfNOYTSmMbykq+sJo0XNdymGBUN3/rWSzhxxtIy+1PEtyIgIczAMETmMQozM0
         46xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715090611; x=1715695411;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ACRiFz5JMT7HATdqtB6Qwjpz19aIG/dJdFvDLMioqk4=;
        b=VjixlTZ+Rg03VTmlPeLP1W3+tOAVExsyeEU/rvDzW458OQBfPM8A3SlC0vCaGMTlGY
         WW6DQiFm4CChGHSgTRXwGky35xfMyusXHklANDr4+rLxI9uTW8wUKIW+VF/qlSWjkzUK
         nTX6TO06bA3cTEBnaSK//olrC0AjAjY2q6kTlwQ14bRXEWWgO7pSQ/AzC7k34xMWqev7
         L+7cpYD8qAFt2yPoqB1gHQu9MPSyOm11oZk9Ep14aDJl028hEPpPvJFtQYlh9o/I3mIw
         5EK18xDkyDw3WupTEcyBq0PwCS8ztVqcAQSL82Gu2k4UKd/fyVRumWNj1Hk/ZGm+R/nX
         JBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKYnrHB/OH5lBuC2b9b67kEmd/CmQ3mOzWY8NljKXJDfgUZ19foV3+vPqkjdA4oKU9sOngdxQmlRXNNQAFWqjWbUy5d1xydMxzJDb5U6qn2MLrGH0fNEkRJ8Nrb5wYaXu3JrcZyms+yxhODbFHOVVp309JhL5fdMfUTfTbEQO5vU7kEhaGD9ZQtayA9VX1sXDPc8P5UhEG
X-Gm-Message-State: AOJu0Yyns0kRVEc4cX0o9FtPUn21QJ41LFDnOPmFgDp2+0ZK+vAc11en
	D5sfDzgdJr9ePMoIqNN8pWOo71lO/QPve9rIzZ/SqzBlQcyndxyU
X-Google-Smtp-Source: AGHT+IHBxCIKJZOjU+GXnLH3UtwF/07SzqBHvP3On8U6hnAh099ag9MfwbvP7+0U55XvbNa/LQfHlg==
X-Received: by 2002:a05:600c:3150:b0:41b:3e4e:bd99 with SMTP id h16-20020a05600c315000b0041b3e4ebd99mr9641420wmo.12.1715090610529;
        Tue, 07 May 2024 07:03:30 -0700 (PDT)
Received: from ?IPv6:2001:8a0:e622:f700:855f:a005:34c7:4367? ([2001:8a0:e622:f700:855f:a005:34c7:4367])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b0041bf3a716b9sm19768132wmq.34.2024.05.07.07.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 07:03:30 -0700 (PDT)
Message-ID: <6c8bf4a2cb2c9494d1a7325d4ca6adb72aad93fa.camel@gmail.com>
Subject: Re: [PATCH v4] can: mcp251xfd: fix infinite loop when xmit fails
From: Vitor Soares <ivitro@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Thomas Kopp
 <thomas.kopp@microchip.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Vitor Soares <vitor.soares@toradex.com>,
 linux-can@vger.kernel.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 07 May 2024 15:03:28 +0100
In-Reply-To: <20240506-bronze-snake-of-imagination-1db027-mkl@pengutronix.de>
References: <20240506144918.419536-1-ivitro@gmail.com>
	 <20240506-bronze-snake-of-imagination-1db027-mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Marc,

On Mon, 2024-05-06 at 17:14 +0200, Marc Kleine-Budde wrote:
> On 06.05.2024 15:49:18, Vitor Soares wrote:
> > From: Vitor Soares <vitor.soares@toradex.com>
> >=20
> > When the mcp251xfd_start_xmit() function fails, the driver stops
> > processing messages, and the interrupt routine does not return,
> > running indefinitely even after killing the running application.
> >=20
> > Error messages:
> > [=C2=A0 441.298819] mcp251xfd spi2.0 can0: ERROR in mcp251xfd_start_xmi=
t: -16
> > [=C2=A0 441.306498] mcp251xfd spi2.0 can0: Transmit Event FIFO buffer n=
ot empty.
> > (seq=3D0x000017c7, tef_tail=3D0x000017cf, tef_head=3D0x000017d0,
> > tx_head=3D0x000017d3).
> > ... and repeat forever.
> >=20
> > The issue can be triggered when multiple devices share the same
> > SPI interface. And there is concurrent access to the bus.
> >=20
> > The problem occurs because tx_ring->head increments even if
> > mcp251xfd_start_xmit() fails. Consequently, the driver skips one
> > TX package while still expecting a response in
> > mcp251xfd_handle_tefif_one().
> >=20
> > This patch resolves the issue by decreasing tx_ring->head and removing
> > the skb from the echo stack if mcp251xfd_start_xmit() fails.
> > Consequently, the package is dropped not been possible to re-transmit.
> >=20
> > Fixes: 55e5b97f003e ("can: mcp25xxfd: add driver for Microchip MCP25xxF=
D SPI
> > CAN")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Vitor Soares <vitor.soares@toradex.com>
> > ---
> > With this approach, some packages get lost in concurrent SPI bus access
> > due to can_put_echo_skb() being called before mcp251xfd_tx_obj_write().
> > The can_put_echo_skb() calls can_create_echo_skb() that consumes the
> > original skb
> > resulting in a Kernel NULL pointer dereference error if return
> > NETDEV_TX_BUSY on
> > mcp251xfd_tx_obj_write() failure.
> > A potential solution would be to change the code to use spi_sync(), whi=
ch
> > would
> > wait for SPI bus to be unlocked. Any thoughts about this?
>=20
> This is not an option. I think you need a echo_skb function that does
> the necessary cleanup, something like:
>=20
> void can_remove_echo_skb(struct net_device *dev, unsigned int idx)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct can_priv *priv =3D=
 netdev_priv(dev);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 priv->echo_skb[idx] =3D NULL;
> }
>=20
> I think you can open-code the "priv->echo_skb[idx] =3D NULL;" directly in
> the driver.
>=20
> And you have to take care of calling netdev_completed_queue(priv->ndev,
> 1, frame_len);

I have tried this approach and got the following trace:

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 858 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0=
x144
Modules linked in: can_raw can tpm_tis_spi tpm_tis_core 8021q garp stp mrp =
llc
rf6
CPU: 0 PID: 858 Comm: cansend Not tainted 6.9.0-rc6-00132-g31a65174a15c-dir=
ty
#16
Hardware name: Toradex Verdin iMX8M Mini WB on Verdin Development Board (DT=
)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
pc : refcount_warn_saturate+0xf4/0x144
lr : refcount_warn_saturate+0xf4/0x144
sp : ffff800080003cc0
x29: ffff800080003cc0 x28: 0000000000000101 x27: ffff0000060ba0ac
x26: 0000000000000000 x25: 0000000000000000 x24: ffff800080003ea4
x23: ffff8000816f9000 x22: 0000000000000000 x21: 0000000000000000
x20: ffff000009e8196c x19: ffff000009e81800 x18: 0000000000000006
x17: ffff7ffffe6dc000 x16: ffff800080000000 x15: 072007200720072e
x14: 0765076507720766 x13: ffff8000817124e0 x12: 000000000000056a
x11: 00000000000001ce x10: ffff80008176a4e0 x9 : ffff8000817124e0
x8 : 00000000ffffefff x7 : ffff80008176a4e0 x6 : 80000000fffff000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000003754500
Call trace
refcount_warn_saturate+0xf4/0x144
sock_wfree+0x158/0x248
skb_release_head_state+0x2c/0x144
kfree_skb_reason+0x30/0xb0
can_dropped_invalid_skb+0x3c/0x17c [can_dev]
mcp251xfd_start_xmit+0x78/0x4e0 [mcp251xfd]
dev_hard_start_xmit+0x98/0x118
sch_direct_xmit+0x88/0x37c
__qdisc_run+0x118/0x66c
net_tx_action+0x158/0x218
__do_softirq+0x10c/0x264
____do_softirq+0x10/0x1c
call_on_irq_stack+0x24/0x4c
do_softirq_own_stack+0x1c/0x28
do_softirq+0x54/0x6c
__local_bh_enable_ip+0x8c/0x98
__dev_queue_xmit+0x224/0xd84
can_send+0xd4/0x2a4 [can
raw_sendmsg+0x270/0x3a0 [can_raw]
sock_write_iter+0xa4/0x110
vfs_write+0x2f0/0x358
ksys_write+0xe8/0x104
__arm64_sys_write+0x1c/0x28
invoke_syscall+0x48/0x118
el0_svc_common.constprop.0+0xc0/0xe0
do_el0_svc+0x1c/0x28
el0_svc+0x34/0xdc
el0t_64_sync_handler+0x100/0x12c
el0t_64_sync+0x190/0x194
--[ end trace 0000000000000000 ]---

My understanding is that can_create_echo_skb() does consume_skb(), which fr=
ees
the original skb and when the stack retry to transmit again it is not there=
.

In consequence of this, I moved the consume_skb() from can_create_echo_skb(=
) to
the driver and I could do can_free_echo_skb() and return NETDEV_TX_BUSY wit=
hout
issues on my tests.

...
err =3D mcp251xfd_tx_obj_write(priv, tx_obj);
if (err) {
	tx_ring->head--;

	if (!echo_err) {
		can_free_echo_skb(ndev, tx_head, &frame_len);
		netdev_completed_queue(ndev, 1, frame_len);
	}

	if (mcp251xfd_get_tx_free(tx_ring))
		netif_wake_queue(ndev);

	if (err =3D=3D -EBUSY)
		return NETDEV_TX_BUSY;

	stats->tx_dropped++;
	if (net_ratelimit())
		netdev_err(priv->ndev,
				"ERROR in %s: %d\n", __func__, err);
}

consume_skb(skb);
...


>=20
> Another option would be to start a workqueue and use spi_sync() in case
> the spi_async() is busy.
>=20
> regards,
> Marc
>=20

Meanwhile, I wonder if there is anything to add to the current patch so I c=
an
address this topic in another patchset.

Best regards,
Vitor Soares


