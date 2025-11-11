Return-Path: <linux-can+bounces-5333-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A3C4DE33
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 13:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563341884327
	for <lists+linux-can@lfdr.de>; Tue, 11 Nov 2025 12:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5464339E909;
	Tue, 11 Nov 2025 12:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brixandersen.dk header.i=@brixandersen.dk header.b="Gsl68v2U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JhkKIiK4"
X-Original-To: linux-can@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72BD39E904;
	Tue, 11 Nov 2025 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864284; cv=none; b=pngNE7NPv78bUPx2XwRFdzIfUmONZoudob9hgDjJKRUEOENuHDCl6jyDkeEQzZDaWS3tGk2D1THhWOzOTTp2JMghUQLlMTXNTH0mtINYljhKcBE4LLPizFi5UwVMg6TmCY9GFe0ZLqqEVDFTN8+lEp38knUeWEIH3Z7htl8LaBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864284; c=relaxed/simple;
	bh=TmJRb1KT87eh5kVIbHv4RzXHvWB2Z1EOf5JFuIxHdNg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fRcT3EQ851MqrIak/ICzae0vDMOaSep2xMdWjVQAr+/Tj0V/bl2otesX9JZkhRLVve4l5mNTQFwiOP5dTojIy6ZqJ3JKxPymfychgZLu2XFcT8XyypN+gwRsN2bVdKTZGKjzpjfGOWdKF2zzomPzs6sZzpp3/3QcNUHbtEECY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brixandersen.dk; spf=pass smtp.mailfrom=brixandersen.dk; dkim=pass (2048-bit key) header.d=brixandersen.dk header.i=@brixandersen.dk header.b=Gsl68v2U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JhkKIiK4; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=brixandersen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brixandersen.dk
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E9697A00AA;
	Tue, 11 Nov 2025 07:31:20 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 11 Nov 2025 07:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=brixandersen.dk;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1762864280; x=1762950680; bh=cMVsMMso39Iyr5Nm1ahF4xCRfNObqn0u
	gVq5DxetITw=; b=Gsl68v2ULqSQezyBS/egyZrb8bFowrLPxsn6bBuY9TfRpW9Y
	EGRGLSA/Fq+qfxDBZ+TBiafdFNbQg0JQQeJO6P+z4AC/QTrUhzgE8TBTusqPGMQI
	RsGR3I0S/X4aSZoqQij7am6Sj8S7pI6LnYNItEKsmCioixphFVpA6FjGregAvL46
	viIjTtaKhLNya7fYG4ri1/vknPGvB/5zkPazVDVEnQewIVWNdufz+yIxM/ihU3yU
	iWNMQpIK3+mV8f4CrsHb9+ljIGrRU52NuLaaW1OkmcciZJacYD7/XLTDTlZFn66t
	j5dfpq4S1l18gDm1EB2m9L8xHa6s606btFBR1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762864280; x=
	1762950680; bh=cMVsMMso39Iyr5Nm1ahF4xCRfNObqn0ugVq5DxetITw=; b=J
	hkKIiK49lyRhGrteTxL2/AYF3zxmijapVzdQfJt/XpNYmQJdi+3UVX+Dp9X7Tl71
	w/VwkDzB+bluLOeFXNRRwcz83IL9vvC/LmMo5fTtlIV97T2AA0fN8zo1/KFfwrTT
	KrTIGvQAFiiFcGjPM1zaL4G/QjFobeZa30093FcxsLcR78njbcFf4PsfHFlUoOic
	dopSE4g8ewzXlcuwA1ARkqZB6Cvnim+GBNRV9KUCdrGVNIZV/J0t4cs+ejQQzWhH
	H2rYll4njP8XYK1dqfiylM0xHGyHdULazRrfDL+BUhhy6dc9czdWpS78ULoj0Y20
	j9DMZopZrtu0gkK2UV/9Q==
X-ME-Sender: <xms:lywTaTBbLBNal4SFtc407ozd-zJ3cYIOAMLxqCUSLPWhhjGmUNFQAg>
    <xme:lywTaaNhv0L1DEDc_z3NxjJBv1c63TZkrUwuhMNieIo-4xSJXR1nfSBlMpacLHvrR
    5NuzyBwc5gaj1sAuK7HTPTuxR74HJ0a3647AmJWWvTGaukOeYYK8-s>
X-ME-Received: <xmr:lywTaczYLQFYfc_02gV3ik9RIym336pn2ZALcH-o58Ynig1jJZ4v0YSwq2wCWmhBexc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduvddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurheptggguffhjgffvefgkfhfvffosehtqhhmtdhhtddvnecuhfhrohhmpefjvghnrhhi
    khcuuehrihigucetnhguvghrshgvnhcuoehhvghnrhhikhessghrihigrghnuggvrhhsvg
    hnrdgukheqnecuggftrfgrthhtvghrnhepleetfeevffejlefgueejhfetieelfeelfffg
    ueevvedtheethfdvuefhfeekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhephhgvnhhrihhksegsrhhigigrnhguvghrshgvnhdrughkpdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmkhhlse
    hpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehmrghilhhhohhlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehmrgigsehstghhnhgvihguvghrshhofhhtrdhnvghtpd
    hrtghpthhtohepfihgsehgrhgrnhguvghgghgvrhdrtghomhdprhgtphhtthhopehkvghr
    nhgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoheplhhinhhugidqtggrnh
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lywTaaX2qccP0p8nBk4LIdH9Ajim4FzPJ2m5SOB3HtJk5unGQgoyng>
    <xmx:lywTaeOd7KCW3vEBawkqsx24rjrA59SWPhbq0U3yWryHSXdUgsM1cQ>
    <xmx:lywTacAmRhBrfHn1PxSanGz01mHOhxd3LEJv9jCNeJvoM7UmPgGH6Q>
    <xmx:lywTabe9O8FOd72UymDMTuuRdpBV_3cBk5lgz6HIa8sOl46WUFerIA>
    <xmx:mCwTad41i03KJmCt_KLbXChpWmBXg1_DWkF3DNV1fWzLT_bwTANtWenH>
Feedback-ID: i203040d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 07:31:18 -0500 (EST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH can 3/3] can: gs_usb: gs_usb_receive_bulk_callback():
 check actual_length before accessing data
From: Henrik Brix Andersen <henrik@brixandersen.dk>
In-Reply-To: <20251108-gs_usb-fix-usb-callbacks-v1-3-8a2534a7ea05@pengutronix.de>
Date: Tue, 11 Nov 2025 13:31:06 +0100
Cc: Vincent Mailhol <mailhol@kernel.org>,
 Maximilian Schneider <max@schneidersoft.net>,
 Wolfgang Grandegger <wg@grandegger.com>,
 kernel@pengutronix.de,
 linux-can@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5BD68A4-076C-4ADD-B2A8-5D8A128D0473@brixandersen.dk>
References: <20251108-gs_usb-fix-usb-callbacks-v1-0-8a2534a7ea05@pengutronix.de>
 <20251108-gs_usb-fix-usb-callbacks-v1-3-8a2534a7ea05@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: Apple Mail (2.3864.100.1.1.5)

Hi,

> On 8 Nov 2025, at 10.01, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
> The URB received in gs_usb_receive_bulk_callback() contains a struct
> gs_host_frame. The length of the data after the header depends on the
> gs_host_frame hf::flags and the active device features (e.g. time
> stamping).
>=20
> Introduce a new function gs_usb_get_minimum_length() and check that we =
have
> at least received the required amount of data before accessing it. =
Only
> copy the data to that skb that has actually been received.
>=20
> Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN =
devices")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> drivers/net/can/usb/gs_usb.c | 65 =
++++++++++++++++++++++++++++++++++++++++----
> 1 file changed, 60 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/can/usb/gs_usb.c =
b/drivers/net/can/usb/gs_usb.c
> index 51f8d694104d..8524d423b029 100644
> --- a/drivers/net/can/usb/gs_usb.c
> +++ b/drivers/net/can/usb/gs_usb.c
> @@ -261,6 +261,11 @@ struct canfd_quirk {
> u8 quirk;
> } __packed;
>=20
> +/* struct gs_host_frame::echo_id =3D=3D GS_HOST_FRAME_ECHO_ID_RX =
indicates
> + * a regular RX'ed CAN frame
> + */
> +#define GS_HOST_FRAME_ECHO_ID_RX 0xffffffff
> +
> struct gs_host_frame {
> struct_group(header,
> u32 echo_id;
> @@ -570,6 +575,43 @@ gs_usb_get_echo_skb(struct gs_can *dev, struct =
sk_buff *skb,
> return len;
> }
>=20
> +static unsigned int
> +gs_usb_get_minimum_length(const struct gs_can *dev, const struct =
gs_host_frame *hf,
> +  unsigned int *data_length_p)
> +{
> + unsigned int minimum_length, data_length;
> +
> + /* TX echo only uses the header */
> + if (hf->echo_id !=3D GS_HOST_FRAME_ECHO_ID_RX) {
> + *data_length_p =3D 0;
> + return sizeof(hf->header);
> + }

Is this correct? The embedded timestamp is also used in the =
gs_usb_get_echo_skb() function.

Regards,
Brix
--=20
Henrik Brix Andersen




