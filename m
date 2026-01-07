Return-Path: <linux-can+bounces-6027-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA634CFFCAC
	for <lists+linux-can@lfdr.de>; Wed, 07 Jan 2026 20:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A778132B260F
	for <lists+linux-can@lfdr.de>; Wed,  7 Jan 2026 18:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE423358DB;
	Wed,  7 Jan 2026 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Jv/MT0q3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="CrVlLEfJ"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (unknown [185.56.87.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA1156CA
	for <linux-can@vger.kernel.org>; Wed,  7 Jan 2026 18:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812158; cv=pass; b=s/GceTH01gPyYBiFeFioSzvCpN7KFcAj/u0DlzRhcTWiM5tjYcN80hGd6q/noZqXyyZxaScbAy12ubIl5bd7LiXw4+aL2mfkgyPFSCv1i9ZfZUEz147MfQ4z8IwXos+dIgMQ5PpyW1UGTBwu/RKxxKnzt7nyvbcdqAH6MjutAyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812158; c=relaxed/simple;
	bh=p3m1YQ/9P5vNTomEXOUxwQentxiVuYEKEgDewVGrR0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7p/fzEcIdA6+DfrYO4X6cCUvb1utiFbSTYJX7QTnbPpfWCPJGEsiyAmXyqZTmYjJAZr0o7I51s+xb7JdHrUCPblz0rOjL0mAkLYbvZJaLGhzjmvduDFdr3HBymJUMLi5Xqk6x5NEl56PKtwzAOKCEGwXaMMSeLNzD1RzlNFMs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Jv/MT0q3; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=CrVlLEfJ; arc=pass smtp.client-ip=185.56.87.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-15n0.prod.antispam.mailspamprotection.com; s=arckey; t=1767812155;
	 b=LL6vYj3ot/ioXsaMDELH0pJLVNBovZMbiKjxqshGvF5UpD/T2HIu7okCzTxYnl1adlQM76LZs6
	  U/CkhhlRKGbs5RgyqJROMyYhJTk89XBvheQk/zi8hqWdpXzE85zWWlBXz0Fvd2uQ8fMM509jGo
	  Px6FMQvdglp6lIGd01SlrJqMpVQpysR9ek9Ac16D4cmYjmImQg3IVF3o+EjYW3UIgml1OJ3VFQ
	  S3Rdz8ASA6NZzesmszuXhEKUjvK8aopSDFpmxfDjGdfbBaJi+yvvK/6s9Z+IXMtV1+SktAW0WG
	  53+e6cztcQRuXo8lzQ//SjQMU7eWyhBtGeUy+0YKWJLGHA==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-15n0.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-15n0.prod.antispam.mailspamprotection.com; s=arckey; t=1767812155;
	bh=p3m1YQ/9P5vNTomEXOUxwQentxiVuYEKEgDewVGrR0I=;
	h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	  Message-ID:Subject:Cc:To:From:Date:DKIM-Signature:DKIM-Signature;
	b=zaHVGutQJLG3G6hwnpL1Ymm6KBTQFxSq2CqyM0/3THMU+uvpDx4D5Ptp2zd9+zmfFsceDyL4hN
	  8M+QwsUTG69CaPnbam1n4o+KB1a0sW+FIdf1DnHURz5RAvTfuwcKUZbjdSTPtZTSvJDVl4YnVC
	  hf3mW63rQosQcpELm+bFOQGV4KgjfLqMLK8GkE6CyoBeLJO1Q4ogc96frm+x4Ruea1hci/x6mb
	  bUjl/POZxlpQw5MA2OtfFeoG2gniGV3uFuWweSV86XurAx6eNhTq69JXFbKHn76G43KBjOzo7Y
	  kN7t+kVZwR0ZyEAXzsVJ51YS/evvYwNuV3fBqt9XGUnxOg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To
	:From:Date:Reply-To:List-Unsubscribe;
	bh=iUMyPLpJ71jeIRwYpzO9IcEWcMDLagnGl8XB+6L+pRY=; b=Jv/MT0q32KsCrShG8T6gTld1YA
	piLv7h5MP8AaZznwEnwuqMobkJkrjT8wG0zy2BaBTPdqNYnTI0KHeQ9QtyEIkFsOjY+k+nq+Nc02Q
	7C282ANsgCz/fhKZ07/fqVU21KWLhkKPxKFkjTNsSyJYfaab0MHD3Dmnssq/xTjYZef0=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-15n0.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vdYh6-00000001sWQ-39YM
	for linux-can@vger.kernel.org;
	Wed, 07 Jan 2026 18:55:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=iUMyPLpJ71jeIRwYpzO9IcEWcMDLagnGl8XB+6L+pRY=; b=CrVlLEfJDO/RE8P7SNCAUqguH4
	SPG4x3JfwN5mPy+ARPsEDM8o24G8SS3JYDYBMyEK2nYpfpx5YW5xEZtSiNcwPj18Cm69rXmhz2iOG
	ehHIZTc785TKpKLFtklMGSTnm8Q02Jaihyi2ahkQAHcA/huI/IktkpxDEA2rg+nwVIrI=;
Received: from [95.248.141.113] (port=62266 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vdYgq-00000000AfQ-1T6g;
	Wed, 07 Jan 2026 18:55:28 +0000
Date: Wed, 7 Jan 2026 19:55:26 +0100
From: Francesco Valla <francesco@valla.it>
To: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aV6sHofXnZuu84OV@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aU6lCL_vrF93lpYa@bywater>
 <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHYGQ0yHSvhOibhvxtFjZ7H3Tczb22JZ1UuaX5kkOtok0JjDgQ@mail.gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 43765d0cf0ca4cfbbdebb15cb78cbcde
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vdYh6-00000001sWQ-39YM-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-15n0.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Matias,

On Wed, Jan 07, 2026 at 05:14:25PM +0100, Matias Ezequiel Vara Larsen wrote:
> On Fri, Dec 26, 2025 at 4:09 PM Francesco Valla <francesco@valla.it> wrote:
> >
> > Hi,
> >
> > On Sun, Dec 14, 2025 at 04:25:54PM +0100, Francesco Valla wrote:
> > > While stress testing this, I noticed that flooding the virtio-can
> > > interface with packets leads to an hang of the interface itself.
> > > I am seeing this issuing, at host side:
> > >
> > >       while true; do cansend can0 123#00; done
> > >
> > > with:
> > >
> > >  - QEMU: the tip of the master branch plus [2]
> > >  - vhost-device: the tip of the main branch
> > >
> > > and the following QEMU invocation:
> > >
> > > qemu-system-x86_64 -serial mon:stdio \
> > >     -m 2G -smp 2 \
> > >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> > >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> > >     -append "loglevel=7 console=ttyS0" \
> > >     -machine memory-backend=pc.ram \
> > >     -object memory-backend-file,id=pc.ram,size=2G,mem-path=/tmp/pc.ram,share=on \
> > >     -chardev socket,id=can0,path=/tmp/sock-can0 \
> > >     -device vhost-user-can-pci,chardev=can0
> > >
> > >
> > > Restarting the interface (i.e.: ip link set down and the up) does not
> > > fix the situation.
> > >
> > > I'll try to do some more testing during the next days.
> >
> > After a deep dive, I _think_ the problem actually lies in vhost-device,
> > since it is not there (or al least, it seems so) using an alternative
> > implementation that uses the qemu socketcan support [0] (implementation
> > which builds on top of the work done by Harald and Mikhail):
> >
> > qemu-system-x86_64 -serial mon:stdio \
> >     -m 2G -smp 2 -enable-kvm \
> >     -kernel $(pwd)/BUILD.bin/arch/x86/boot/bzImage \
> >     -initrd /home/francesco/SRC/LINUX_KERNEL/initramfs.gz \
> >     -append "loglevel=7 console=ttyS0" \
> >     -object can-bus,id=canbus0 -object can-host-socketcan,id=canhost0,if=vcan0,canbus=canbus0 \
> >     -device virtio-can-pci,canbus=canbus0
> >
> > Unfortunately, my Rust knoweledge is not sufficient to understand the
> > vhost-device implementation [1]; the issue seems to be related to the
> > host->guest vring becoming empty and not refilling anymore.
> >
> 
> Can you try with
> https://github.com/MatiasVara/vhost-device/commits/fix-for-923/?

I'll stress test it during the night, but this seems to fix it. Before
it was reproducible in a consistent manner after mere seconds, while i
now in a bunch of runs I never reproduced it.

I also agree with your analysis on the commit.

> 
> Thanks, Matias
> 
> 

Thank you!

Francesco


