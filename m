Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6C2DB5F9
	for <lists+linux-can@lfdr.de>; Tue, 15 Dec 2020 22:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgLOVoA (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 16:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728694AbgLOVnx (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 16:43:53 -0500
Received: from coruscant.sevenbyte.org (coruscant.sevenbyte.org [IPv6:2001:19f0:6c01:abf:5400:1ff:fe40:fb77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54978C0613D6
        for <linux-can@vger.kernel.org>; Tue, 15 Dec 2020 13:43:11 -0800 (PST)
Received: from [IPv6:2003:cd:370e:4d00:7d0:30c6:72d:ea04] (p200300cd370e4d0007d030c6072dea04.dip0.t-ipconnect.de [IPv6:2003:cd:370e:4d00:7d0:30c6:72d:ea04])
        (Authenticated sender: stefan@rumpelsepp.org)
        by coruscant.sevenbyte.org (Postfix) with ESMTPSA id 4E0133ED93;
        Tue, 15 Dec 2020 22:43:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rumpelsepp.org;
        s=dkim; t=1608068589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vZmAAdZ34ogT4An3YekaqKUqsOnNOdfZtOiIZnAwcfc=;
        b=iejQEpbrrIGQcu68letGIMmj7Dlcdh0vhmY6L8Z4x52cjAYbgY2SgUotdAXF7vK5kIDvFf
        g/rbG29faUG91o5KFQwlANdJ0GF/uIRnzL/yPedkurQEYndWSHkzXL73RkERMnkUB3S9zF
        skNfQ/JkJCHa4Krr1u1z4Nz+6Jj26N/ItPbS9XrfFybycNP8eMEGViyiap/dQxPgzgK1nF
        yareQyjSYOi4IYNbWcaEr7dsiDXx27fTDUr38yOF8XYK7mRFSEYr9U8rqVJc8QyI0QCdIi
        9KpMWfrbXfPF75Nqgzq1tc8sKkstX9GxQHQCy9i6FSZu5wcEcghjejfJoYlJg7ewf/n00l
        6DfdxAA9DOnjNnqfeAJI8s9y+7HppiMISoom/A7bUW2FisvyZmFnDbl6UlAnl/9JcnnF2n
        iwuBV17aItxC+GGX2S5pi8FQ4zIX3FmZ9U42GDkOCuP55mKYDAhnuZdGmNaQoI0ItWhR7U
        iHRU3P8lxazwTERFzbgpWLVLck3bok6kaQdyOzL5RLGkX2cnoSDnca9xy0VckptziqZn4z
        znOaUYeAq33oTpv7NgqwLPdUVbM8VoiXrGfuYzhQnecBE1g3jDOSEF8xVzC0jk6wR2eQNC
        xG22AoKZL/PND1ZTiEH3fG+7QxIhRHHgeuXaULx9GeFSw5EjdjL2E=
Message-ID: <1d893ac53e1aec2fe1e731ea7b123b801c9457e7.camel@rumpelsepp.org>
Subject: Re: pcan: usb_submit_urb() hangs in peak_usb_ndo_start_xmit()
From:   Stefan Tatschner <stefan@rumpelsepp.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     ferdinand.jarisch@aisec.fraunhofer.de,
        Tobias Specht <tobias.specht@aisec.fraunhofer.de>
Date:   Tue, 15 Dec 2020 22:43:07 +0100
In-Reply-To: <b713bc9b-d530-cc58-4fd8-2c0eaac1397b@pengutronix.de>
References: <ad68c4ebcdadb31cbf9fd78c9ad38b57ee9ef562.camel@rumpelsepp.org>
         <b713bc9b-d530-cc58-4fd8-2c0eaac1397b@pengutronix.de>
Content-Type: multipart/mixed; boundary="=-kvaXeg1eqw5jVR56fB1y"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


--=-kvaXeg1eqw5jVR56fB1y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2020-12-15 at 22:20 +0100, Marc Kleine-Budde wrote:
> You can sniff the USB traffic with wireshark...
> 
> https://wiki.wireshark.org/CaptureSetup/USB

Yeah. The mentioned last can_frame is never sent. I am not that aware
of the usb protocol and I am currently not able to parse what is
actually happening after frame No. 259 in the attached pcap.
Nevertheless, it never sends the "25 FF".

Stefan

--=-kvaXeg1eqw5jVR56fB1y
Content-Type: application/vnd.tcpdump.pcap; name="pcap-sniff.pcap.gz"
Content-Disposition: attachment; filename="pcap-sniff.pcap.gz"
Content-Transfer-Encoding: base64

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



--=-kvaXeg1eqw5jVR56fB1y--

