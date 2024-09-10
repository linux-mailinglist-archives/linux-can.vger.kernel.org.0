Return-Path: <linux-can+bounces-1458-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2405D973015
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 11:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3049282320
	for <lists+linux-can@lfdr.de>; Tue, 10 Sep 2024 09:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D63F14F12C;
	Tue, 10 Sep 2024 09:57:22 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACCF14D431
	for <linux-can@vger.kernel.org>; Tue, 10 Sep 2024 09:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725962241; cv=none; b=rQMhACOvYmnkp1o2n35VBorWt4nvHVYQKeclBK72/d6wFPq7pauOrFYTZIBVKuhLFKVaesnSHEqL5R/fa/UwB2c4KxC8y4X+kbio9C0EutMGdmlVzyDStnXvbYL3mUYEIvj4yky/nIoVKGZdSWKMk5yZ0xM32tHzfD2qqpv7tVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725962241; c=relaxed/simple;
	bh=iuKcWRgU7l3dQAT7jiihI2/RR5S4eqkuDlzakX+eAs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofdyNXgsxrp7jFv8cGZ0b8RZgjNIc+nZKpFGP7DS1BbeQEuq4tHgeWuo2bIW02tmPML1qlsXn8uaVfcDidHxH/ELeWY+aeWsXBgc8M5WPG1iT8EpXLpTmwTmLFy0iFj1ouoHar53V0QKH/gW/SDyR1h85pxMG/aZbZo3AbPpwP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1snxcI-0005Uj-OW; Tue, 10 Sep 2024 11:56:58 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1snxcH-006rjx-55; Tue, 10 Sep 2024 11:56:57 +0200
Received: from pengutronix.de (pd9e595f8.dip0.t-ipconnect.de [217.229.149.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C2D713375DD;
	Tue, 10 Sep 2024 09:56:56 +0000 (UTC)
Date: Tue, 10 Sep 2024 11:56:56 +0200
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Simon Horman <horms@kernel.org>, Nathan Chancellor <nathan@kernel.org>
Cc: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Heiko Stuebner <heiko@sntech.de>, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, llvm@lists.linux.dev, 
	patches@lists.linux.dev
Subject: Re: [PATCH] can: rockchip_canfd: fix return type of
 rkcanfd_start_xmit()
Message-ID: <20240910-utopian-meticulous-dodo-4ec230-mkl@pengutronix.de>
References: <20240906-rockchip-canfd-wifpts-v1-1-b1398da865b7@kernel.org>
 <20240909084448.GU2097826@kernel.org>
 <20240909-arcane-practical-petrel-015d24-mkl@pengutronix.de>
 <20240909143546.GX2097826@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mtff2ca2w5gsezcq"
Content-Disposition: inline
In-Reply-To: <20240909143546.GX2097826@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org


--mtff2ca2w5gsezcq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.09.2024 15:35:46, Simon Horman wrote:
> On Mon, Sep 09, 2024 at 10:57:06AM +0200, Marc Kleine-Budde wrote:
> > On 09.09.2024 09:44:48, Simon Horman wrote:
> > > On Fri, Sep 06, 2024 at 01:26:41PM -0700, Nathan Chancellor wrote:
> > > > With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
> > > > indirect call targets are validated against the expected function
> > > > pointer prototype to make sure the call target is valid to help mit=
igate
> > > > ROP attacks. If they are not identical, there is a failure at run t=
ime,
> > > > which manifests as either a kernel panic or thread getting killed. A
> > > > warning in clang aims to catch these at compile time, which reveals:
> > > >=20
> > > >   drivers/net/can/rockchip/rockchip_canfd-core.c:770:20: error: inc=
ompatible function pointer types initializing 'netdev_tx_t (*)(struct sk_bu=
ff *, struct net_device *)' (aka 'enum netdev_tx (*)(struct sk_buff *, stru=
ct net_device *)') with an expression of type 'int (struct sk_buff *, struc=
t net_device *)' [-Werror,-Wincompatible-function-pointer-types-strict]
> > > >     770 |         .ndo_start_xmit =3D rkcanfd_start_xmit,
> > > >         |                           ^~~~~~~~~~~~~~~~~~
> > > >=20
> > > > ->ndo_start_xmit() in 'struct net_device_ops' expects a return type=
 of
> > > > 'netdev_tx_t', not 'int' (although the types are ABI compatible). A=
djust
> > > > the return type of rkcanfd_start_xmit() to match the prototype's to
> > > > resolve the warning.
> > > >=20
> > > > Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip =
CAN-FD controller")
> > > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > >=20
> > > Thanks, I was able to reproduce this problem at build time
> > > and that your patch addresses it.
> >=20
> > FTR: the default clang in Debian unstable, clang-16.0.6 doesn't support
> > this. With clang-20 from experimental it works, haven't checked older
> > versions, though.
>=20
> FTR: I checked using 18.1.8 from here [1][2].
>=20
> [1] https://mirrors.edge.kernel.org/pub/tools/llvm/
> [2] https://mirrors.edge.kernel.org/pub/tools/llvm/files/

I was a bit hasty yesterday, clang-20 and W=3D1 produces these errors:

| include/linux/vmstat.h:517:36: error: arithmetic between different enumer=
ation types ('enum node_stat_item' and 'enum lru_list') [-Werror,-Wenum-enu=
m-conversion]
|   517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr=
_"
|       |                               ~~~~~~~~~~~ ^ ~~~
| 1 error generated.

However I fail to reproduce the ndo_start_xmit problem. Even with 18.1.8
=66rom kernel.org.


The following command (ARCH is unset, compiling x86 -> x86) produces the
above shown "vmstat.h" problems....

| $ make LLVM=3D1 LLVM_IAS=3D1 LLVM_SUFFIX=3D-20 drivers/net/can/rockchip/ =
 W=3D1 CONFIG_WERROR=3D0

=2E.. but not the ndo_start_xmit problem.


Am I missing a vital .config option?

| $ grep "CLANG\|CFI" .config
| CONFIG_CC_IS_CLANG=3Dy
| CONFIG_CLANG_VERSION=3D200000
| CONFIG_CFI_AUTO_DEFAULT=3Dy
| CONFIG_FUNCTION_PADDING_CFI=3D11
| CONFIG_LTO_CLANG=3Dy
| CONFIG_ARCH_SUPPORTS_LTO_CLANG=3Dy
| CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy
| CONFIG_HAS_LTO_CLANG=3Dy
| CONFIG_LTO_CLANG_THIN=3Dy
| CONFIG_ARCH_SUPPORTS_CFI_CLANG=3Dy
| CONFIG_ARCH_USES_CFI_TRAPS=3Dy
| CONFIG_CFI_CLANG=3Dy
| # CONFIG_CFI_PERMISSIVE is not set


V=3D1 gives this output:

|   clang-20 -Wp,-MMD,drivers/net/can/rockchip/.rockchip_canfd-core.o.d
|   -nostdinc -Iarch/x86/include -I./arch/x86/include/generated
|   -Iinclude -I./include -Iarch/x86/include/uapi
|   -I./arch/x86/include/generated/uapi -Iinclude/uapi
|   -I./include/generated/uapi -include include/linux/compiler-version.h
|   -include include/linux/kconfig.h -include
|   include/linux/compiler_types.h -D__KERNEL__
|   --target=3Dx86_64-linux-gnu -fintegrated-as
|   -Werror=3Dunknown-warning-option -Werror=3Dignored-optimization-argument
|   -Werror=3Doption-ignored -Werror=3Dunused-command-line-argument
|   -fmacro-prefix-map=3D=3D -Wundef -DKBUILD_EXTRA_WARN1 -std=3Dgnu11
|   -fshort-wchar -funsigned-char -fno-common -fno-PIE
|   -fno-strict-aliasing -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx
|   -fcf-protection=3Dbranch -fno-jump-tables -m64 -falign-loops=3D1
|   -mno-80387 -mno-fp-ret-in-387 -mstack-alignment=3D8 -mskip-rax-setup
|   -mtune=3Dgeneric -mno-red-zone -mcmodel=3Dkernel -Wno-sign-compare
|   -fno-asynchronous-unwind-tables -mretpoline-external-thunk
|   -mindirect-branch-cs-prefix -mfunction-return=3Dthunk-extern
|   -fpatchable-function-entry=3D11,11 -fno-delete-null-pointer-checks -O2
|   -fstack-protector-strong -fomit-frame-pointer
|   -fno-stack-clash-protection -fno-lto -flto=3Dthin -fsplit-lto-unit
|   -fvisibility=3Dhidden -fsanitize=3Dkcfi -falign-functions=3D16
|   -fstrict-flex-arrays=3D3 -fno-strict-overflow -fno-stack-check -Wall
|   -Wundef -Werror=3Dimplicit-function-declaration -Werror=3Dimplicit-int
|   -Werror=3Dreturn-type -Werror=3Dstrict-prototypes -Wno-format-security
|   -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member
|   -Wmissing-declarations -Wmissing-prototypes -Wframe-larger-than=3D2048
|   -Wno-gnu -Wvla -Wno-pointer-sign -Wcast-function-type
|   -Wimplicit-fallthrough -Werror=3Ddate-time
|   -Werror=3Dincompatible-pointer-types -Wenum-conversion -Wextra
|   -Wunused -Wmissing-format-attribute -Wmissing-include-dirs
|   -Wunused-const-variable -Wno-missing-field-initializers
|   -Wno-type-limits -Wno-shift-negative-value -Wno-sign-compare
|   -Wno-unused-parameter -g -gdwarf-5 -DDEBUG
|   -Idrivers/net/can/rockchip -Idrivers/net/can/rockchip -DMODULE
|   -DKBUILD_BASENAME=3D'"rockchip_canfd_core"'
|   -DKBUILD_MODNAME=3D'"rockchip_canfd"'
|   -D__KBUILD_MODNAME=3Dkmod_rockchip_canfd -c -o
|   drivers/net/can/rockchip/rockchip_canfd-core.o
|   drivers/net/can/rockchip/rockchip_canfd-core.c
| In file included from drivers/net/can/rockchip/rockchip_canfd-core.c:25:
| In file included from drivers/net/can/rockchip/rockchip_canfd.h:11:
| In file included from include/linux/can/dev.h:18:
| In file included from include/linux/can/bittiming.h:9:
| In file included from include/linux/netdevice.h:38:
| In file included from include/net/net_namespace.h:43:
| In file included from include/linux/skbuff.h:17:
| In file included from include/linux/bvec.h:10:
| In file included from include/linux/highmem.h:8:
| In file included from include/linux/cacheflush.h:5:
| In file included from arch/x86/include/asm/cacheflush.h:5:
| In file included from include/linux/mm.h:2232:
| include/linux/vmstat.h:517:36: warning: arithmetic between different enum=
eration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conv=
ersion]
|   517 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr=
_"
|       |                               ~~~~~~~~~~~ ^ ~~~
| 1 warning generated.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--mtff2ca2w5gsezcq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUEC6huC2BN0pvD5fKDiiPnotvG8FAmbgF+UACgkQKDiiPnot
vG+I2wf/Uov3eSkXqoiq4vrvpJA6Vt32qVb9Rx0KaydYu9oBuUvIlztrXujb0uhA
+Z40eWCMvfkfXu35Lr/bMXmii8tKJc7NebFPfYXaCiFgeQ+DbW1mTzhF6IP4zph8
Oc95A+P0vjPwbDbE45ybEuJeOY7CehIC8Ow6fDHgMdbv8/LAISg1cfJhVQai5Ll4
/LkmzzJb+XCx1ZlCDM6AKg7lqwqzi/jGFc0DG9gICA2LVr8hc8qxDouiLoZyrbgo
JkBHf0DkV+xtE+exKufX75BnCMEwRS5+8Ocxml69V1CJHdNmk7SWkJ1nt/lu15u8
N+wrgEqhqMVeExcK81LQAHJKFsXZUQ==
=5QMc
-----END PGP SIGNATURE-----

--mtff2ca2w5gsezcq--

