Return-Path: <linux-can+bounces-1903-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA869BCD32
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 13:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB6521F21E82
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 12:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1706C1D5AB7;
	Tue,  5 Nov 2024 12:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="bfvlDpdK"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF41D54F7;
	Tue,  5 Nov 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730811580; cv=none; b=bGqRL+c7yEH4m6pFnXoBb7Xe6IzJQ+RbU3u5PlY/FHtiSkwZrUgctxrftqLJ9YAJnXkdA3yu1hQH1HkTzBMIT/aoXNmc1+9lorMq4JEeGHty5Nm/osdLF6+RzatHuzwxWFPHByaFMyQNOtoxCFpFBOGAOkwGRfbVPDyDYKOppzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730811580; c=relaxed/simple;
	bh=f1fyhwzDrFHtSFP4vTzZuKJENU4e6knKeqbXH+P3N64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujRo3GyTf2LagT//ATtIdbv4Qtcl2apiHAjXaQLTjIPBildnRnuaKPzylvmnkblBHhrf56rT4n8Eplp3HLrSW8S1pvAkhIjtcVX9Lb2bSURQbi/lSVlMXXO6K7oXR68x2gWqje6rkQ6mF/u27VsJLd637O4nzvFLLYYbjNOY6Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=bfvlDpdK; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=XxLTtdEv77RFkBJ0GumRUG1a52HxmpFh6vs9dIwA7JU=; b=bfvlDp
	dKutbLSGv8O9mdMr6+mY6/5hrp363YMJOxpPf+hcOuoXLQK7XzGw3awnguKh8ohH58ZEZ5qyYGMK7
	NyL8q+sWlY46iqIfnBogBaIed6OqzaPPlDvtPd4jq79JKOZo6sS5TzKmDYqhJbIi67zd0APtCgiBj
	hhA+Dq6aeEMFLpe9xwqFDe+a0+bFm1qBzv2N+aM4pdVdzfItMLHuk48ekVpAQyTtBjcD2gj8tLO7g
	Cp01jLTYjNuSa7shDdbHaoKT64u4UlnRTCexvIFdtLYuEKq/e6xxRTlC85bChcYdtz0u3rFwyy2jN
	OyvLpRf+t7olmnSDFSU/IqW8INqg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1t8J9h-0001oS-8x; Tue, 05 Nov 2024 13:59:33 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1t8J9g-000KTO-1f;
	Tue, 05 Nov 2024 13:59:32 +0100
Date: Tue, 5 Nov 2024 13:59:31 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: can: convert tcan4x5x.txt to DT schema
Message-ID: <g2knbmyi7cy4xnkospby7xtp6t4f2ppfdbtdyjteltrlnaihcp@gdjhp4n5w7u3>
References: <20241104125342.1691516-1-sean@geanix.com>
 <dq36jlwfm7hz7dstrp3bkwd6r6jzcxqo57enta3n2kibu3e7jw@krwn5nsu6a4d>
 <wdn2rtfahf3iu6rsgxm6ctfgft7bawtp6vzhgn7dffd54i72lu@r4v5lizhae57>
 <60901c39-b649-4a20-a06a-7faa7ddc9346@kernel.org>
 <mtuev7pve5ltr6vvknp2bwtwg2m7mzxduzshzbr7y3i7mwbzy6@qjbdjyb56nrv>
 <f5a28e36-ef80-4ccf-b615-03fb10eb661e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5a28e36-ef80-4ccf-b615-03fb10eb661e@kernel.org>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27449/Tue Nov  5 10:36:43 2024)

On Tue, Nov 05, 2024 at 01:41:26PM +0100, Krzysztof Kozlowski wrote:

[...]

> > Schema check will fail, but driver wize it will work just fine.
> 
> Schema will not fail. That's the problem - no errors will be ever
> reported. The entire point of the schema, in contrast to TXT, is to
> detect errors and that ridiculous wildcard used as front compatible
> affects/reduces detection.

NOW I get it :)

diff --git a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
index f1d18a5461e0..4fb5e5e80a03 100644
--- a/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
+++ b/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
@@ -169,7 +169,7 @@ examples:
         #size-cells = <0>;

         can@0 {
-            compatible = "ti,tcan4552", "ti,tcan4x5x";
+            compatible = "ti,tcan4552";
             reg = <0>;
             clocks = <&can0_osc>;
             pinctrl-names = "default";

Would result in a schema check fail, but the driver will never be probed.

> 
> > Agree that is kinda broken.
> > If I have time I can try to fix that later.
> 
> No, the fix is to drop the wildcard alone, as I said in your RFC.

@Mark, would you be okay with fixing the wildcard in this series?
We have some out-of-tree dtb's that will need fixing, but I get it would be
prefered to get this fixed.

> 
> > 
> > Please explain one more time for me. Is this a comment on the if
> > sentence or the broken behavior of the driver?
> 
> This is just generic comment, nothing to change here because you decided
> not to fix that wildcard from old binding.

Thanks for the clarification!

@Mark, @Krzysztof: What to do from here?

/Sean

