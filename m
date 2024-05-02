Return-Path: <linux-can+bounces-537-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A793C8B9D01
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 17:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABCA1C21D64
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 15:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37AC156C6A;
	Thu,  2 May 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjwYpEbc"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB70154C15;
	Thu,  2 May 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662195; cv=none; b=jVEBvp6970Jq51+TNhzgc+WIrwqoDmZjjnWpahu3bkpe+MYdTfn7BJqgPw9YsgddWDGw/+LeEOuF9Cn7I5OXlJpoVDcL4P1VwySGY1yC3ebkFcWsujoKZsBZr9c4RmDsEoKSG/tNgWByoIWKN6dFa9v4r0wutI0g9293Sokipfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662195; c=relaxed/simple;
	bh=0/D/3orQyLIxlrLlfuPBXHhZ+OC7Ep+EQJbm8XOpe94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKyJwYtzQIylCBfo15O5uSDSBZHUGjO0TMZTCHyiNfLy4Eun8PxFZY2YeDHDSd00zJqxu1b9LLrIPW/YXnKS3pVHcnVbQc7nXmzkMKWPJbsj5ysmM8L7028D233GCdV8kIIJ5E7vJgxG5jRwgdGK912AeUo8iqAMYLF7OWTuYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjwYpEbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF93C4AF1A;
	Thu,  2 May 2024 15:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714662195;
	bh=0/D/3orQyLIxlrLlfuPBXHhZ+OC7Ep+EQJbm8XOpe94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jjwYpEbcYKt++DFA3dEJjELaJbghgGFNOT+1SqU5w4Ca/kIOSW5LPC508Wr6JW/xJ
	 Qa13mKDjvobwhq0k6cMrL/nnqDdFnupgocDVebKuEZLkaU4Gv/cPPWVNGGJd7BUsf2
	 rQ3TBTSTVSN4iI+AJz5VYKUdCDKbNFTWKWZ/67h6SE6EgByvybpC28MJAYOY+rKKS4
	 wTS+R45kjV9v5Cfv9ZWZphP5JsOAySEUlPuzW+2glyBQdMz9wYnn+FsjMgdkGmAp7x
	 Z12AlZ4VnLdCJTa/+73roWWbwI5aC3wYHifh0xhurp+0ZvQQCq/zdkBhk3pLt3bvu5
	 8E1Qj87U+mn8w==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e1fa824504so9252041fa.0;
        Thu, 02 May 2024 08:03:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUkqbzfXUGL8b9ZwHC02XOZOLpZGAbnb6MOOVX5EFQeI3gUuOInjPV3Q3PW/RWUYOqCQy5/zzfXQiCw2dJvmtwxQipatSJnvir0DFyCLBkXBrp9p8/LX2XxRgphtsVNJQU8J+Sq6BgT1fIsBcPxqoME21+TXfqN/kCFxioDa0t6VLOL4uKT7Zg55/beI1hFKx34R7J7FPxb3yKc0x6NEGqdAhG9OYPGoN3/f9Qdog9rl+q0KlDRAjF4
X-Gm-Message-State: AOJu0YzW8CEups6a96c+SOkL+RuUhLdUF076wHFRW2p6drN9jkLlq/dG
	pxdKhUCOFXKutWKvOxBAf7uzv4FwhzyxT74EGmWqDvXXetZWcXhJuH2Yfc8Q4eQsZT2pOHAcQ0C
	2yxZo4NaycUgDcLq9lOQWtenq1A==
X-Google-Smtp-Source: AGHT+IGES7kDbfk0VUx7WlN+rqE+2KtZ3O8wqcOG/0tlTyJbKym9ll1q8hr3CrUhSN2mTjRc2qgzAnvzqQtLGFf5DGo=
X-Received: by 2002:a2e:9ccc:0:b0:2e1:e795:3f81 with SMTP id
 g12-20020a2e9ccc000000b002e1e7953f81mr1275404ljj.44.1714662193358; Thu, 02
 May 2024 08:03:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
 <20240502075534.882628-7-christoph.fritz@hexdev.de> <171464227142.1356329.4931419696225319861.robh@kernel.org>
 <48c55b05dae4628d4e811178bfd5e855ac93ee77.camel@hexdev.de>
In-Reply-To: <48c55b05dae4628d4e811178bfd5e855ac93ee77.camel@hexdev.de>
From: Rob Herring <robh@kernel.org>
Date: Thu, 2 May 2024 10:03:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK0__mzwNHuq4enJ3uvQTNWGYyk=TGYnnFX8kLDoGuNeQ@mail.gmail.com>
Message-ID: <CAL_JsqK0__mzwNHuq4enJ3uvQTNWGYyk=TGYnnFX8kLDoGuNeQ@mail.gmail.com>
Subject: Re: [PATCH v2 06/12] dt-bindings: net/can: Add serial (serdev) LIN adapter
To: christoph.fritz@hexdev.de
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andreas Lauser <andreas.lauser@mercedes-benz.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Benjamin Tissoires <bentiss@kernel.org>, devicetree@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Paolo Abeni <pabeni@redhat.com>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-input@vger.kernel.org, Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
	Oliver Hartkopp <socketcan@hartkopp.net>, "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 6:03=E2=80=AFAM Christoph Fritz
<christoph.fritz@hexdev.de> wrote:
>
> On Thu, 2024-05-02 at 04:31 -0500, Rob Herring (Arm) wrote:
> > On Thu, 02 May 2024 09:55:28 +0200, Christoph Fritz wrote:
> > > This patch adds dt-bindings for serial LIN bus adapters. These adapte=
rs are
> > > basically just LIN transceivers that get hard-wired with serial devic=
es.
> > >
> > > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > > ---
> > >  .../bindings/net/can/hexdev,lin-serdev.yaml   | 32 +++++++++++++++++=
++
> > >  1 file changed, 32 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/net/can/hexdev,=
lin-serdev.yaml
> > >
> >
> > My bot found errors running 'make dt_binding_check' on your patch:
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.example.dtb=
: /example-0/serial/linbus: failed to match any schema with compatible: ['l=
inux,lin-serdev']
>
> Yes, that's obviously still false and will be fixed in v3.
>
> >
> > doc reference errors (make refcheckdocs):
> >
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2024=
0502075534.882628-7-christoph.fritz@hexdev.de
> >
> > The base for the series is generally the latest rc1. A different depend=
ency
> > should be noted in *this* patch.
> >
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> >
> > pip3 install dtschema --upgrade
> >
> > Please check and re-submit after running the above command yourself. No=
te
> > that DT_SCHEMA_FILES can be set to your schema file to speed up checkin=
g
> > your schema. However, it must be unset to test all examples with your s=
chema.
> >
>
> I'm wondering why my local run of dt_binding_check does not catch this:
>
> $ pip3 install dtschema --upgrade
> Requirement already satisfied: dtschema in ./venv/lib/python3.11/site-pac=
kages (2024.4)
> Requirement already satisfied: ruamel.yaml>0.15.69 in ./venv/lib/python3.=
11/site-packages (from dtschema) (0.18.6)
> Requirement already satisfied: jsonschema<4.18,>=3D4.1.2 in ./venv/lib/py=
thon3.11/site-packages (from dtschema) (4.17.3)
> Requirement already satisfied: rfc3987 in ./venv/lib/python3.11/site-pack=
ages (from dtschema) (1.3.8)
> Requirement already satisfied: pylibfdt in ./venv/lib/python3.11/site-pac=
kages (from dtschema) (1.7.0.post1)
> Requirement already satisfied: attrs>=3D17.4.0 in ./venv/lib/python3.11/s=
ite-packages (from jsonschema<4.18,>=3D4.1.2->dtschema) (23.2.0)
> Requirement already satisfied: pyrsistent!=3D0.17.0,!=3D0.17.1,!=3D0.17.2=
,>=3D0.14.0 in ./venv/lib/python3.11/site-packages (from jsonschema<4.18,>=
=3D4.1.2->dtschema) (0.20.0)
> Requirement already satisfied: ruamel.yaml.clib>=3D0.2.7 in ./venv/lib/py=
thon3.11/site-packages (from ruamel.yaml>0.15.69->dtschema) (0.2.8)
>
> $ git diff
> diff --git a/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.=
yaml b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> index c178eb9be1391..385cbe132258d 100644
> --- a/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> +++ b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> @@ -27,6 +27,6 @@ examples:
>    - |
>      serial {
>          linbus {
> -            compatible =3D "hexdev,lin-serdev";
> +            compatible =3D "linux,lin-serdev";
>          };
>      };
>
> $ make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindin=
gs/net/can/hexdev,lin-serdev.yaml
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/dtc/dtc.o
>   HOSTCC  scripts/dtc/flattree.o
>   HOSTCC  scripts/dtc/fstree.o
>   HOSTCC  scripts/dtc/data.o
>   HOSTCC  scripts/dtc/livetree.o
>   HOSTCC  scripts/dtc/treesource.o
>   HOSTCC  scripts/dtc/srcpos.o
>   HOSTCC  scripts/dtc/checks.o
>   HOSTCC  scripts/dtc/util.o
>   LEX     scripts/dtc/dtc-lexer.lex.c
>   YACC    scripts/dtc/dtc-parser.tab.[ch]
>   HOSTCC  scripts/dtc/dtc-lexer.lex.o
>   HOSTCC  scripts/dtc/dtc-parser.tab.o
>   HOSTLD  scripts/dtc/dtc
>   HOSTCC  scripts/dtc/libfdt/fdt.o
>   HOSTCC  scripts/dtc/libfdt/fdt_ro.o
>   HOSTCC  scripts/dtc/libfdt/fdt_wip.o
>   HOSTCC  scripts/dtc/libfdt/fdt_sw.o
>   HOSTCC  scripts/dtc/libfdt/fdt_rw.o
>   HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
>   HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
>   HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
>   HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
>   HOSTCC  scripts/dtc/fdtoverlay.o
>   HOSTLD  scripts/dtc/fdtoverlay
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
> /home/ch/linux/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml: =
ignoring, error in schema: properties: brcm,tperst-clk-ms: type
> /home/ch/linux/Documentation/devicetree/bindings/hwmon/microchip,emc2305.=
yaml: ignoring, error in schema: properties: emcs205,max-state: description
>   DTEX    Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.exa=
mple.dts
>   DTC_CHK Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.exa=
mple.dtb
>
> Any ideas?
>
> I'm using a python venv here, maybe this is related?

No. There are 2 possibilities. What kernel version are you on? This
check is enabled with the '-m' option on dt-validate which was only
recently (6.9) enabled by default for the bindings. You can enable it
with 'DT_CHECKER_FLAGS=3D"-m"'. The other possibility is I noticed that
the flag has an interaction with DT_SCHEMA_FILES in that we don't set
the flag by default if DT_SCHEMA_FILES is set. (If you explicitly set
DT_CHECKER_FLAGS in the newer kernels it should still give the
warning.)  I think we don't enable it because you would get false
positives if your example has compatible strings not documented within
the schema you are testing. I need to double check that as how the
tools work in this regard has evolved. In any case, DT_SCHEMA_FILES is
a shortcut and it is always possible your changes can introduce
warnings in other examples, so ultimately "make dt_binding_check" has
to be run without DT_SCHEMA_FILES set.

Rob

