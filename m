Return-Path: <linux-can+bounces-535-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3058B999E
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 13:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52D2B21106
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 11:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C854F5FDA9;
	Thu,  2 May 2024 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="w8Daq/DZ"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A20B58228;
	Thu,  2 May 2024 11:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647840; cv=none; b=q1F56w+w4iF8Di2jTjNtNGawUbLFCzHWvdyrQo5V+/CXTZgUfLuhOiPndAh4hXx6odZ7vOnP2mdBSkjMc/tAWUK9beF1sEgBg9XYnxwABRe2FX2ybDpvQ1MmT9Y7x6sqopQBDTJaj5vSgQQnrGWtkzBwSDlMNI0GB+yR9989yj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647840; c=relaxed/simple;
	bh=fBAaoFlZfEYbgWcR99nmTfqssQTQgju1ZEXTW9eeSuA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iQI3vas9qkDFJfRGSikZQw2Y5z51xB9e3ZsunS9aojhByCeAyFnrH8o0iACSeP+ntx05oXmTB7ZteG5FwHoWudAw/iXOQ+XLFesRwB63R+PB5QTuEN+zo9vF+fqhPnNadP1tr3/nfw9A6WdBmn8U/KT8dZAn/dBH8AHyu3JSNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=w8Daq/DZ; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
	In-Reply-To:Date:Cc:To:Reply-To:From:Subject:Message-ID:Sender:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xrJZEtQCkguErjBYfgKPVVDWS0LKbQlBAZ4XgRsohl4=; b=w8Daq/DZymap2DLm1CeW8Nw4I5
	j+RVpAvi3xizokSsLbEw6qsCi2BiEen1O7JWqsLMoZjR4P8OX+LC554+ib4cTAeBLrLC0WZIwJnPf
	cYvUWLR5yY88z44C/H4/D/JjkM8Y27hHNhfN1aYOWxCA0ibj/54xsTQrxABJ6g9NFbss=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2UE3-001Z33-21;
	Thu, 02 May 2024 13:03:44 +0200
Message-ID: <48c55b05dae4628d4e811178bfd5e855ac93ee77.camel@hexdev.de>
Subject: Re: [PATCH v2 06/12] dt-bindings: net/can: Add serial (serdev) LIN
 adapter
From: Christoph Fritz <christoph.fritz@hexdev.de>
Reply-To: christoph.fritz@hexdev.de
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Sebastian Reichel
 <sre@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Jiri Kosina <jikos@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>,  Andreas Lauser
 <andreas.lauser@mercedes-benz.com>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Benjamin Tissoires <bentiss@kernel.org>, devicetree@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>, Jakub
 Kicinski <kuba@kernel.org>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org,  linux-input@vger.kernel.org, Pavel Pisa
 <pisa@cmp.felk.cvut.cz>, Oliver Hartkopp <socketcan@hartkopp.net>, "David S
 . Miller" <davem@davemloft.net>
Date: Thu, 02 May 2024 13:03:42 +0200
In-Reply-To: <171464227142.1356329.4931419696225319861.robh@kernel.org>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
	 <20240502075534.882628-7-christoph.fritz@hexdev.de>
	 <171464227142.1356329.4931419696225319861.robh@kernel.org>
Organization: hexDEV GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-05-02 at 04:31 -0500, Rob Herring (Arm) wrote:
> On Thu, 02 May 2024 09:55:28 +0200, Christoph Fritz wrote:
> > This patch adds dt-bindings for serial LIN bus adapters. These adapters are
> > basically just LIN transceivers that get hard-wired with serial devices.
> > 
> > Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> > ---
> >  .../bindings/net/can/hexdev,lin-serdev.yaml   | 32 +++++++++++++++++++
> >  1 file changed, 32 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.example.dtb: /example-0/serial/linbus: failed to match any schema with compatible: ['linux,lin-serdev']

Yes, that's obviously still false and will be fixed in v3.

> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240502075534.882628-7-christoph.fritz@hexdev.de
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 

I'm wondering why my local run of dt_binding_check does not catch this:

$ pip3 install dtschema --upgrade
Requirement already satisfied: dtschema in ./venv/lib/python3.11/site-packages (2024.4)
Requirement already satisfied: ruamel.yaml>0.15.69 in ./venv/lib/python3.11/site-packages (from dtschema) (0.18.6)
Requirement already satisfied: jsonschema<4.18,>=4.1.2 in ./venv/lib/python3.11/site-packages (from dtschema) (4.17.3)
Requirement already satisfied: rfc3987 in ./venv/lib/python3.11/site-packages (from dtschema) (1.3.8)
Requirement already satisfied: pylibfdt in ./venv/lib/python3.11/site-packages (from dtschema) (1.7.0.post1)
Requirement already satisfied: attrs>=17.4.0 in ./venv/lib/python3.11/site-packages (from jsonschema<4.18,>=4.1.2->dtschema) (23.2.0)
Requirement already satisfied: pyrsistent!=0.17.0,!=0.17.1,!=0.17.2,>=0.14.0 in ./venv/lib/python3.11/site-packages (from jsonschema<4.18,>=4.1.2->dtschema) (0.20.0)
Requirement already satisfied: ruamel.yaml.clib>=0.2.7 in ./venv/lib/python3.11/site-packages (from ruamel.yaml>0.15.69->dtschema) (0.2.8)

$ git diff
diff --git a/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
index c178eb9be1391..385cbe132258d 100644
--- a/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
+++ b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
@@ -27,6 +27,6 @@ examples:
   - |
     serial {
         linbus {
-            compatible = "hexdev,lin-serdev";
+            compatible = "linux,lin-serdev";
         };
     };

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
  HOSTCC  scripts/basic/fixdep
  HOSTCC  scripts/dtc/dtc.o
  HOSTCC  scripts/dtc/flattree.o
  HOSTCC  scripts/dtc/fstree.o
  HOSTCC  scripts/dtc/data.o
  HOSTCC  scripts/dtc/livetree.o
  HOSTCC  scripts/dtc/treesource.o
  HOSTCC  scripts/dtc/srcpos.o
  HOSTCC  scripts/dtc/checks.o
  HOSTCC  scripts/dtc/util.o
  LEX     scripts/dtc/dtc-lexer.lex.c
  YACC    scripts/dtc/dtc-parser.tab.[ch]
  HOSTCC  scripts/dtc/dtc-lexer.lex.o
  HOSTCC  scripts/dtc/dtc-parser.tab.o
  HOSTLD  scripts/dtc/dtc
  HOSTCC  scripts/dtc/libfdt/fdt.o
  HOSTCC  scripts/dtc/libfdt/fdt_ro.o
  HOSTCC  scripts/dtc/libfdt/fdt_wip.o
  HOSTCC  scripts/dtc/libfdt/fdt_sw.o
  HOSTCC  scripts/dtc/libfdt/fdt_rw.o
  HOSTCC  scripts/dtc/libfdt/fdt_strerror.o
  HOSTCC  scripts/dtc/libfdt/fdt_empty_tree.o
  HOSTCC  scripts/dtc/libfdt/fdt_addresses.o
  HOSTCC  scripts/dtc/libfdt/fdt_overlay.o
  HOSTCC  scripts/dtc/fdtoverlay.o
  HOSTLD  scripts/dtc/fdtoverlay
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema.json
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
/home/ch/linux/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml: ignoring, error in schema: properties: brcm,tperst-clk-ms: type
/home/ch/linux/Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml: ignoring, error in schema: properties: emcs205,max-state: description
  DTEX    Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.example.dts
  DTC_CHK Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.example.dtb

Any ideas?

I'm using a python venv here, maybe this is related?

Thanks
  -- Christoph

