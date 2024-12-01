Return-Path: <linux-can+bounces-2293-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970189DF564
	for <lists+linux-can@lfdr.de>; Sun,  1 Dec 2024 12:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A494161ECF
	for <lists+linux-can@lfdr.de>; Sun,  1 Dec 2024 11:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A1E07BB15;
	Sun,  1 Dec 2024 11:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="UVQ0R0aI";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="6mBawzoZ"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E8F54740
	for <linux-can@vger.kernel.org>; Sun,  1 Dec 2024 11:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733053133; cv=pass; b=NezfB0FMrbMsJ+LgUu9VcI8kfEdJaY312XuQWmRE2BoEHupHR1efsiCPt8J1E10WT2G2SzxWVFk2hYn4yReofEim+cyEl+5MDncGQZuELzqQfLmGl4r8XWr3QCgbzEr51LlncMPOWmna1B0/ZBW8J/USLoqPcFDJeALfEg/3bU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733053133; c=relaxed/simple;
	bh=RngPfMTA8LXAI4Jvo/yQfZDPR4ARb8d7x//UE43+4Dc=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=JNCPLDMXyDJzOX+wfo3Xtohil4ryPHJagjc9HSxKVILpT7wib2BUwccvBIiVpiEoI7vrBzGAT0Fn6MloeULJgp5lZsByqVfg9WRg8aHZcYstXIGsxT0UN5/TuxiIaQnX9yLWVWUSE6htELidwS7DYDQbFNlbbag8AP326tYNuy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=UVQ0R0aI; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=6mBawzoZ; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1733052766; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Sxgorbj9YTbg1FPe2FzmvjdgGAg3NuxcgvEvmpW198Yeu+6IFL/ogGKuNHR50Q6U2D
    ty45Fx2ALgEvIyrTi/ha1nv3KwwXas1Ha2atahXfY9FsiyChWBsepKYGYzCZuuCJWepI
    T6eUc3NgBU04r4svUtWtESXdoMLBEgj2LoSY8qKp6GLXdUDOQcQ/TfR01ndne7aBQTxv
    MW98A6xbsj92251JAGrkrMTuoeVOIRIjB6ZODxTal+3wM1Uj/od9+xb/H/pwW730ZUdT
    HDRFK9FVE55X9UsBf0+pr+QhpfBkfmX8g57raa76255nkQJMx9nKUfezyUzsmeiv0oS1
    Cr9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733052766;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LJt4zwFsy0+crphYezif9g8oCdWeCSwGSofxJp3UxV8=;
    b=Jj5+i+NyvN0pdeufPhX5rXbWlO7meBdQDpY4UpzVWKg8MMh26bT1f/LfuCwOGSXrXk
    2ehaPGrtaeGjr942/twk25pjVsbi7HKKYPHqP/7yTqXI0RLUBCi7LX/7aK1JfvfBi2wO
    oJfVfirbVbZ7RkBt5D3TaDROD4wAJezWY6D7HUl9VFYMOJ0OQ6fuI9FyESRuqS/S3tE8
    FcGgRqySBae5h0nm8TsWbIvIpQMhFqbScOK7ZKB1zKS2YbWqGhh4B8B36Uf92w9mi1Sk
    A0mbw0zf4IfmRhPPqoVPV1LTtoWR0aBXA+UGRqMXdNKWZG5/pwaF3cH5Ze1k7Gsi20Ud
    CXLQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733052766;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LJt4zwFsy0+crphYezif9g8oCdWeCSwGSofxJp3UxV8=;
    b=UVQ0R0aImC66vYkWYiqURPBhoPqD3G/BFMAyithm6FSJis2DgWfVesf4gXoAxsMz8u
    JIqaTm67QbOlH/NrniYlTCBh7KF/PC/dsKwbeihqbwqssa3K7WZzA1qkCQyLH4YEP/a6
    whC2qBmTwCgump3Rknu2g9rhoQvSqJGsgTOgBeSfDsBEHCUOLRpwrneaWEEqtWvwx2WB
    j9R9Jm08cgPuF6EB3/5khvCKq/1XJS82gBWI1J61MfhMczbLiEYdphlsdghSO/xigJTJ
    HiQTKs/WS5rq6gygDtVe58SSwc50OpL0R/OYWgY7mzK2TelfpvRKRGR8ZCOYeSCNn0P7
    Xtng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733052766;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=LJt4zwFsy0+crphYezif9g8oCdWeCSwGSofxJp3UxV8=;
    b=6mBawzoZYqVIX+N8SuEHPTQ58Ha7A2SJ55IXGPCUhMRoFGxQaEGMkWtS7oHglDzh0J
    20UoeI6RVAXfmQFI9/Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSXVT6pap5"
Received: from [192.168.60.115]
    by smtp.strato.de (RZmta 51.2.11 DYNA|AUTH)
    with ESMTPSA id K63ada0B1BWjgYM
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 1 Dec 2024 12:32:45 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------qYmhuop00eCwbEErSAYhh6nJ"
Message-ID: <77331a33-ac82-4cfb-9881-159d6d2daf58@hartkopp.net>
Date: Sun, 1 Dec 2024 12:32:39 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/14] can: netlink: add CAN XL
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robert Nawrath <mbro1689@gmail.com>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
 <ea52eb8f-c59d-445a-bf4d-26f2772f7426@hartkopp.net>
 <a9d8eb65-c88d-4bc9-b0c2-c0e0799ea5bd@wanadoo.fr>
 <23c914cf-0af2-4619-9f83-e4b6339ef65f@hartkopp.net>
 <12e013c2-d6ff-42b2-91ef-921db4e7ee0e@hartkopp.net>
Content-Language: en-US
In-Reply-To: <12e013c2-d6ff-42b2-91ef-921db4e7ee0e@hartkopp.net>
Content-Transfer-Encoding: 8bit

This is a multi-part message in MIME format.
--------------qYmhuop00eCwbEErSAYhh6nJ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Vincent,

I found some issues in the code and fixed up the problems below.

The funniest thing was this copy/paste problem in netlink.h ;-)
(see attached patch with my changes)

The patch descriptions are not finalized - but it becomes usable now.
I will add the CAN XL transceiver switch to the controlmode definitions.

For the PWM configuration we would need some more discussions.

https://lore.kernel.org/linux-can/20241201112333.6950-1-socketcan@hartkopp.net/T/#u
https://lore.kernel.org/linux-can/20241201112230.6917-1-socketcan@hartkopp.net/T/#t

Best regards,
Oliver

On 21.11.24 21:10, Oliver Hartkopp wrote:
> Hi Vincent,
> 
> On 11.11.24 16:32, Oliver Hartkopp wrote:
> 
>> No problem! I will give some feedback when I managed to integrate the 
>> extended netlink API to my driver.
> 
> I managed to set up my CAN XL dev board with the latest Linux kernel 
> (6.13 merge) and upgraded to Ubuntu 24.04 LTS.
> 
> Applying your RFC patches for the kernel and the iproute2 package 
> (including the sed hack) works great.
> 
> While the xl transceiver switch and the and the PWM configuration (with 
> 3 values with 6 bit each) are still missing I tried your current code 
> as-is.
> 
> # modprobe dummyxl
> (created can0)
> 
> # ip link set can0 type can bitrate 500000 xbitrate 8000000 xl on 
> dbitrate 4000000 fd on
> 
> # ip -det link show can0
> 7: can0: <NOARP> mtu 2060 qdisc noop state DOWN mode DEFAULT group 
> default qlen 10
>      link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
>      can <FD,TDC-AUTO,XL> state STOPPED restart-ms 0
> 
> Should there be a XTDC-AUTO too?
> 
>        bitrate 500000 sample-point 0.875
>        tq 12 prop-seg 69 phase-seg1 70 phase-seg2 20 sjw 10 brp 1
>        dummyxl nominal: tseg1 2..256 tseg2 2..128 sjw 1..128 brp 1..512 
> brp_inc 1
>        dbitrate 4000000 dsample-point 0.750
>        dtq 12 dprop-seg 7 dphase-seg1 7 dphase-seg2 5 dsjw 2 dbrp 1
>        tdco 15 tdcf 0
> 
> Should the tdc* values be placed behind dbrp 1 without a line break?
> The gso/gro stuff below also heavily exceeds the 80 columns. And it is 
> more in the same shape like with the CAN CC settings.
> 
>        dummyxl FD: dtseg1 2..256 dtseg2 2..128 dsjw 1..128 dbrp 1..512 
> dbrp_inc 1
>        tdco 0..127 tdcf 0..127
> 
> same here
> 
>        xbitrate 8000000 xsample-point 0.700
>        xtq 12 xprop-seg 3 xphase-seg1 3 xphase-seg2 3 xsjw 1 xbrp 1
> 
> xtdco/xtdcf missing here?
> 
>        dummyxl XL: xtseg1 2..256 xtseg2 2..128 xsjw 1..128 xbrp 1..512 
> xbrp_inc 1
> 
> xtdco/xtdcf missing here?
> 
>        clock 80000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 
> gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 
> 65536 gso_ipv4_max_size 65536 gro_ipv4_max_size 65536
> 
> Best regards,
> Oliver

--------------qYmhuop00eCwbEErSAYhh6nJ
Content-Type: text/x-patch; charset=UTF-8; name="fix-for-vincents-rfc.patch"
Content-Disposition: attachment; filename="fix-for-vincents-rfc.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Nhbi9kZXYvbmV0bGluay5jIGIvZHJpdmVycy9u
ZXQvY2FuL2Rldi9uZXRsaW5rLmMKaW5kZXggMGE2NzAwMTk0YWIwLi42NGY2NzVlODc0ZjYg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L2Nhbi9kZXYvbmV0bGluay5jCisrKyBiL2RyaXZl
cnMvbmV0L2Nhbi9kZXYvbmV0bGluay5jCkBAIC0xMjcsMTAgKzEyNywxOSBAQCBzdGF0aWMg
aW50IGNhbl92YWxpZGF0ZShzdHJ1Y3QgbmxhdHRyICp0YltdLCBzdHJ1Y3QgbmxhdHRyICpk
YXRhW10sCiAJCWlmIChlcnIpIHsKIAkJCU5MX1NFVF9FUlJfTVNHX0ZNVChleHRhY2ssCiAJ
CQkJCSAgICJUREMgcGFyYW1ldGVycyBhcmUgaW5jb3JyZWN0Iik7CiAJCQlyZXR1cm4gZXJy
OwogCQl9CisJCWVyciA9IGNhbl92YWxpZGF0ZV90ZGMoZGF0YVtJRkxBX0NBTl9YTF9URENd
LAorCQkJCSAgICAgICBjbS0+ZmxhZ3MgJiBDQU5fQ1RSTE1PREVfWExfVERDX0FVVE8sCisJ
CQkJICAgICAgIGNtLT5mbGFncyAmIENBTl9DVFJMTU9ERV9YTF9URENfTUFOVUFMLAorCQkJ
CSAgICAgICBleHRhY2spOworCQlpZiAoZXJyKSB7CisJCQlOTF9TRVRfRVJSX01TR19GTVQo
ZXh0YWNrLAorCQkJCQkgICAiWEwgVERDIHBhcmFtZXRlcnMgYXJlIGluY29ycmVjdCIpOwor
CQkJcmV0dXJuIGVycjsKKwkJfQogCX0KIAogCWlmIChkYXRhW0lGTEFfQ0FOX0JJVFRJTUlO
R10pIHsKIAkJc3RydWN0IGNhbl9iaXR0aW1pbmcgYnQ7CiAKQEAgLTU3MCwyMCArNTc5LDIx
IEBAIHN0YXRpYyBzaXplX3QgY2FuX2dldF9zaXplKGNvbnN0IHN0cnVjdCBuZXRfZGV2aWNl
ICpkZXYpCiAJcmV0dXJuIHNpemU7CiB9CiAKIHN0YXRpYyBpbnQgY2FuX3RkY19maWxsX2lu
Zm8oc3RydWN0IHNrX2J1ZmYgKnNrYiwgIGNvbnN0IHN0cnVjdCBuZXRfZGV2aWNlICpkZXYs
CiAJCQkgICAgIHN0cnVjdCBkYXRhX2JpdHRpbWluZ19wYXJhbXMgKmRidF9wYXJhbXMsCi0J
CQkgICAgIGJvb2wgdGRjX2lzX2VuYWJsZWQsIGJvb2wgdGRjX21hbnVhbCkKKwkJCSAgICAg
Ym9vbCB0ZGNfaXNfZW5hYmxlZCwgYm9vbCB0ZGNfbWFudWFsLAorCQkJICAgICBpbnQgaWZs
YV9jYW5fdGRjX3R5cGUpCiB7CiAJc3RydWN0IG5sYXR0ciAqbmVzdDsKIAlzdHJ1Y3QgY2Fu
X3RkYyAqdGRjID0gJmRidF9wYXJhbXMtPnRkYzsKIAljb25zdCBzdHJ1Y3QgY2FuX3RkY19j
b25zdCAqdGRjX2NvbnN0ID0gZGJ0X3BhcmFtcy0+dGRjX2NvbnN0OwogCiAJaWYgKCF0ZGNf
Y29uc3QpCiAJCXJldHVybiAwOwogCi0JbmVzdCA9IG5sYV9uZXN0X3N0YXJ0KHNrYiwgSUZM
QV9DQU5fVERDKTsKKwluZXN0ID0gbmxhX25lc3Rfc3RhcnQoc2tiLCBpZmxhX2Nhbl90ZGNf
dHlwZSk7CiAJaWYgKCFuZXN0KQogCQlyZXR1cm4gLUVNU0dTSVpFOwogCiAJaWYgKHRkY19t
YW51YWwgJiYKIAkgICAgKG5sYV9wdXRfdTMyKHNrYiwgSUZMQV9DQU5fVERDX1REQ1ZfTUlO
LCB0ZGNfY29uc3QtPnRkY3ZfbWluKSB8fApAQCAtNzAyLDExICs3MTIsMTIgQEAgc3RhdGlj
IGludCBjYW5fZmlsbF9pbmZvKHN0cnVjdCBza19idWZmICpza2IsIGNvbnN0IHN0cnVjdCBu
ZXRfZGV2aWNlICpkZXYpCiAJICAgIChubGFfcHV0KHNrYiwgSUZMQV9DQU5fQklUUkFURV9N
QVgsCiAJCSAgICAgc2l6ZW9mKHByaXYtPmJpdHJhdGVfbWF4KSwKIAkJICAgICAmcHJpdi0+
Yml0cmF0ZV9tYXgpKSB8fAogCiAJICAgIGNhbl90ZGNfZmlsbF9pbmZvKHNrYiwgZGV2LCAm
cHJpdi0+ZmQsIGNhbl9mZF90ZGNfaXNfZW5hYmxlZChwcml2KSwKLQkJCSAgICAgIHByaXYt
PmN0cmxtb2RlICYgQ0FOX0NUUkxNT0RFX1REQ19NQU5VQUwpIHx8CisJCQkgICAgICBwcml2
LT5jdHJsbW9kZSAmIENBTl9DVFJMTU9ERV9URENfTUFOVUFMLAorCQkJICAgICAgSUZMQV9D
QU5fVERDKSB8fAogCiAJICAgIGNhbl9jdHJsbW9kZV9leHRfZmlsbF9pbmZvKHNrYiwgcHJp
dikgfHwKIAogCSAgICAocHJpdi0+eGwuZGF0YV9iaXR0aW1pbmcuYml0cmF0ZSAmJgogCSAg
ICAgbmxhX3B1dChza2IsIElGTEFfQ0FOX1hMX0RBVEFfQklUVElNSU5HLApAQCAtNzIyLDEx
ICs3MzMsMTIgQEAgc3RhdGljIGludCBjYW5fZmlsbF9pbmZvKHN0cnVjdCBza19idWZmICpz
a2IsIGNvbnN0IHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCiAJCSAgICAgc2l6ZW9mKCpwcml2
LT54bC5kYXRhX2JpdHJhdGVfY29uc3QpICoKIAkJICAgICBwcml2LT54bC5kYXRhX2JpdHJh
dGVfY29uc3RfY250LAogCQkgICAgIHByaXYtPnhsLmRhdGFfYml0cmF0ZV9jb25zdCkpIHx8
CiAKIAkgICAgY2FuX3RkY19maWxsX2luZm8oc2tiLCBkZXYsICZwcml2LT54bCwgY2FuX3hs
X3RkY19pc19lbmFibGVkKHByaXYpLAotCQkJICAgICAgcHJpdi0+Y3RybG1vZGUgJiBDQU5f
Q1RSTE1PREVfWExfVERDX01BTlVBTCkKKwkJCSAgICAgIHByaXYtPmN0cmxtb2RlICYgQ0FO
X0NUUkxNT0RFX1hMX1REQ19NQU5VQUwsCisJCQkgICAgICBJRkxBX0NBTl9YTF9UREMpCiAJ
ICAgICkKIAogCQlyZXR1cm4gLUVNU0dTSVpFOwogCiAJcmV0dXJuIDA7CmRpZmYgLS1naXQg
YS9pbmNsdWRlL3VhcGkvbGludXgvY2FuL25ldGxpbmsuaCBiL2luY2x1ZGUvdWFwaS9saW51
eC9jYW4vbmV0bGluay5oCmluZGV4IGM4MWZkMTUzYTA3Zi4uZjRmYjhlZWE4ZjM1IDEwMDY0
NAotLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvY2FuL25ldGxpbmsuaAorKysgYi9pbmNsdWRl
L3VhcGkvbGludXgvY2FuL25ldGxpbmsuaApAQCAtMTAyLDEyICsxMDIsMTIgQEAgc3RydWN0
IGNhbl9jdHJsbW9kZSB7CiAjZGVmaW5lIENBTl9DVFJMTU9ERV9GRF9OT05fSVNPCQkweDgw
CS8qIENBTiBGRCBpbiBub24tSVNPIG1vZGUgKi8KICNkZWZpbmUgQ0FOX0NUUkxNT0RFX0ND
X0xFTjhfRExDCTB4MTAwCS8qIENsYXNzaWMgQ0FOIERMQyBvcHRpb24gKi8KICNkZWZpbmUg
Q0FOX0NUUkxNT0RFX1REQ19BVVRPCQkweDIwMAkvKiBGRCB0cmFuc2NlaXZlciBhdXRvbWF0
aWNhbGx5IGNhbGN1bGF0ZXMgVERDViAqLwogI2RlZmluZSBDQU5fQ1RSTE1PREVfVERDX01B
TlVBTAkJMHg0MDAJLyogRkQgVERDViBpcyBtYW51YWxseSBzZXQgdXAgYnkgdXNlciAqLwog
I2RlZmluZSBDQU5fQ1RSTE1PREVfWEwJCQkweDgwMAkvKiBDQU4gWEwgbW9kZSAqLwotI2Rl
ZmluZSBDQU5fQ1RSTE1PREVfWExfVERDX0FVVE8JMHgyMDAJLyogWEwgdHJhbnNjZWl2ZXIg
YXV0b21hdGljYWxseSBjYWxjdWxhdGVzIFREQ1YgKi8KLSNkZWZpbmUgQ0FOX0NUUkxNT0RF
X1hMX1REQ19NQU5VQUwJMHg0MDAJLyogWEwgVERDViBpcyBtYW51YWxseSBzZXQgdXAgYnkg
dXNlciAqLworI2RlZmluZSBDQU5fQ1RSTE1PREVfWExfVERDX0FVVE8JMHgxMDAwCS8qIFhM
IHRyYW5zY2VpdmVyIGF1dG9tYXRpY2FsbHkgY2FsY3VsYXRlcyBURENWICovCisjZGVmaW5l
IENBTl9DVFJMTU9ERV9YTF9URENfTUFOVUFMCTB4MjAwMAkvKiBYTCBURENWIGlzIG1hbnVh
bGx5IHNldCB1cCBieSB1c2VyICovCiAKIC8qCiAgKiBDQU4gZGV2aWNlIHN0YXRpc3RpY3MK
ICAqLwogc3RydWN0IGNhbl9kZXZpY2Vfc3RhdHMgewo=

--------------qYmhuop00eCwbEErSAYhh6nJ--

