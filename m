Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27B948EB82
	for <lists+linux-can@lfdr.de>; Fri, 14 Jan 2022 15:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbiANOTg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 Jan 2022 09:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237533AbiANOTd (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Jan 2022 09:19:33 -0500
Received: from mx1.llgoewer.de (mx1.llgoewer.de [IPv6:2a01:4f8:1c1c:7d4a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F66C061574
        for <linux-can@vger.kernel.org>; Fri, 14 Jan 2022 06:19:32 -0800 (PST)
DKIM-Signature: a=rsa-sha256; bh=HTbTsGCjF5J0tFfcdav4zYkelpy4jdhsLh2P6OxFMAY=;
 c=relaxed/relaxed; d=llgoewer.de;
 h=Subject:Subject:Sender:To:To:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@llgoewer.de; s=default; t=1642169969; v=1; x=1642601969;
 b=HH4gMg6mnYphcDQFzIBwhK468sQSC1M7HTqwqTKqwyIyBDw2r7PVzh/s/Cm4qCczt19Oq9LV
 V7cu5ANqGnvRaoFk/h5VVUyOKcuawBM6gr1tSGs6BNKXsqR8aFU/4V/b0bdMDJ0sDv6bpscWlNn
 FpjlCIl5PKgEhzZR4ElFtVDZAtjL8pIZDRiWMtnamVGTuUPWMWnFUi4/DuErE0VjhCQ9uG261B1
 DwhFLNmWus0ovpbHYKYv/7rXLpfsRg0nng9UqXvce4+rCwDEnDsLFZZooQ+p7PDcTa+bVIb8gHq
 lfev4lsehV1CFnK6CW02A1OnNTmNiPtKX/9zNF+tC0PEg==
Received: by mx1.llgoewer.de (envelope-sender <maik@llgoewer.de>) with
 ESMTPS id ca40060a; Fri, 14 Jan 2022 14:19:29 +0000
Date:   Fri, 14 Jan 2022 14:19:29 +0000
From:   Maik =?utf-8?B?QWxsZ8O2d2Vy?= <maik@llgoewer.de>
To:     linux-can@vger.kernel.org
Subject: Re: can-isotp: TX stmin violations
Message-ID: <20220114141929.mz34evi65cgurgek@ganymed>
References: <20220103155254.3htprmrdjur3ke3l@ganymed>
 <d54c6374-bdf4-dfe8-9e9c-5547a743afdb@hartkopp.net>
 <27389f5f-1681-7440-15bd-3c67e4e5daa9@posteo.de>
 <c20468e2-0f9f-bcca-da0f-f3f6470d91be@hartkopp.net>
 <6175074d-6562-91c9-3dce-22ca99815910@posteo.de>
 <19adffae-443c-78bc-fb8c-61ec792a7b6d@hartkopp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19adffae-443c-78bc-fb8c-61ec792a7b6d@hartkopp.net>
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

On 22-01-05 08:36, Oliver Hartkopp wrote:
> 
> In fact the discussion hits a valid point. On the one side you might think
> about a time slotted receive task that might only be able to process a frame
> inside this slot. At least in the 'very early' days of CAN transport
> protocols I've heard about such weird implementations.
> 
> On the other side (as we can see from the jitter in Maiks's original
> question) we face different requirements in todays implementations. Here an
> *average* result makes sense. But this is no implementation requirement but
> a testing requirement to relax the STmin timing checks then.

I did some more testing and the issue seems not to be related to the isotp driver.

The system we are using is an i.MX-based one and we have three CANs.
Two of those are flexcan, the third is a mcp2518fd (mcp251xfd).

I can not reproduce the timing issue on the flexcans, only on the MCP.


Nonetheless, the point regarding the average st is really interesting, thanks Patrick!


Regards,
Maik 
